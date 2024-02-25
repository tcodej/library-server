const express = require('express');
const mcache = require('memory-cache');
// const fetch = require('node-fetch');
const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const fs = require('fs');
const path = require('path');
const db = require('./db.cjs');

const app = express();

// 24 hours
const ttl = 1440;

// use for debugging
const disableCache = false;

// requires dotenv in index.cjs to populate this
const { DISCOGS_TOKEN, DISCOGS_USERNAME } = process.env;
const API_ROOT = '';
const discogsAPI = 'https://api.discogs.com';

const cache = (duration) => {
	return (req, res, next) => {
		const key = 'mediabin-server-'+ req.originalUrl || req.url;
		const cachedBody = mcache.get(key);

		if (cachedBody && !disableCache) {
			res.send(cachedBody);
			return;

		} else {
			res.sendResponse = res.send;
			res.send = (body) => {
				mcache.put(key, body, duration * 1000);
				res.sendResponse(body);
			}

			next();
		}
	}
}

app.get('/', (req, res) => {
	res.send('MediaBin Server v1.0');
});

// utility endpoint to aid in troubleshooting
app.get(API_ROOT +'/clearcache', (req, res) => {
	mcache.clear();
	res.send({ message: 'Cache cleared' });
});

// get collection from discogs (not used)
// /users/{username}/collection/folders/{folder_id}/releases
// folder_id=0 is all, folder_id=1 is uncategorized
app.get(API_ROOT +'/discogs/collection/:page', (req, res) => {
	const { page } = req.params;
	const url = `${discogsAPI}/users/${DISCOGS_USERNAME}/collection/folders/0/releases?token=${DISCOGS_TOKEN}&page=${page}&per_page=100`;

	(async () => {
		const response = await fetch(url, {
		    method: 'GET',
		    headers: { 'Content-Type': 'application/json' }
		});

		const resp = await response.json();

		res.json(resp);
	})();
});

// load a discogs release by id and import it
// it does not check if the release already exists...
app.get(API_ROOT +'/discogs/import/:id', (req, res) => {
	const { type, id} = req.params;
	const url = `${discogsAPI}/releases/${id}?token=${DISCOGS_TOKEN}`;

	(async () => {
		const response = await fetch(url, {
		    method: 'GET',
		    headers: { 'Content-Type': 'application/json' }
		});

		const resp = await response.json();

		// save to db
		saveRelease(resp);

		res.json(resp);
	})();
});


// return a discogs release or master record
// type: releases|masters
app.get(API_ROOT +'/discogs/:type/:id', (req, res) => {
	const { type, id} = req.params;
	const url = `${discogsAPI}/${type}/${id}?token=${DISCOGS_TOKEN}`;

	(async () => {
		const response = await fetch(url, {
		    method: 'GET',
		    headers: { 'Content-Type': 'application/json' }
		});

		const resp = await response.json();

		if (type === 'releases') {
			// check to see if a cover image needs to be downloaded
			saveCover(resp);
		}

		res.json(resp);
	})();
});

// currently not using this as search/filtering is handled on the front-end
app.get(API_ROOT +'/search', (req, res) => {
	let q = '';
	let sql = '';
	let msg = '';

	// default search
	if (req.query) {
		let sqlArr = [];
		let terms = [];

		// escape characters
		q = addSlashes(req.query.q);
		sql = `SELECT * FROM media WHERE `;

		['artist', 'title'].forEach((column) => {
			q.split(' ').forEach((keyword) => {
				terms.push(`${column} LIKE '%${keyword}%'`);
			});

			sqlArr.push('('+ terms.join(' AND ') +')');
			terms = [];
		});

		sql += sqlArr.join(' OR ');

	} else {
		msg = 'Search query missing.';
	}

	(async () => {
		let resp = await db.query(sql);

		res.json({
			message: msg,
			result: resp,
			total: resp.length
		});
	})();
});

// id is only used for type release or collection
app.get(API_ROOT +'/feed/:type/:id?', cache(ttl), (req, res) => {
	let sql = '';
	let msg = '';
	const select = 'SELECT * FROM media';
	const orderBy = 'ORDER BY artist ASC, released ASC, title ASC';

	(async () => {
		switch (req.params.type) {
			// release by database id
			case 'release':
				sql = `${select} WHERE id=${req.params.id}`;
				msg = 'Release loaded';
			break;
			// all media
			case 'media':
				sql = `${select} ${orderBy}`;
				msg = 'Media list loaded.';
			break;
			case 'collection':
				sql = `${select} WHERE collection_id=${req.params.id} ${orderBy}`;
				msg = 'Collection loaded.';
			break;
			case 'collections':
				sql = 'SELECT * FROM collections ORDER BY name ASC';
				msg = 'Collections loaded.';
			break;
		}

		const resp = await db.query(sql);

		res.json({
			message: msg,
			result: resp,
			total: resp.length
		});
	})();
});

console.log('MediaBin Server is available.');
console.log(`Cache is ${disableCache ? 'disabled' : 'enabled'}`);



const addSlashes = (str) => {
    return str.replace(/\\/g, '\\\\')
		.replace(/\u0008/g, '\\b')
		.replace(/\t/g, '\\t')
		.replace(/\n/g, '\\n')
		.replace(/\f/g, '\\f')
		.replace(/\r/g, '\\r')
		.replace(/'/g, '\\\'')
		.replace(/"/g, '\\"');
}

const saveCover = (release) => {
	let imageURL;
	const dirPath = __dirname +'/files/covers';
	const fileName = `${release.id}.jpg`;

	if (release.images && release.images.length > 0) {
		imageURL = release.images[0].uri150;
	}

	if (release.id) {
		getMediaItem(release.id).then(item => {
			// only save if the item doesn't already have a cover image
			if (!item.cover && imageURL) {
				fetch(imageURL)
					.then((response) => response.buffer())
					.then((buffer) => {
						// Write the buffer to a file
						fs.writeFile(path.join(dirPath, fileName), buffer, (err) => {
							if (err) {
								console.error(err);

							} else {
								console.log('Cover for '+ release.id +' downloaded successfully');
								item.cover = fileName;
								db.update(item);
							}
						});
					})

					.catch((error) => {
						console.error(error);
					});
			}
		});

	} else {
		console.log('No release_id');
	}
}

const saveRelease = (release) => {
	console.log(`Saving ${release.id} to the database.`);
	let media = {
		artist: release.artists && release.artists[0].name,
		title: release.title,
		released: release.released || release.year,
		label: release.labels && release.labels[0].name,
		release_id: release.id,
		format: release.formats[0].name +', '+ release.formats[0].descriptions.join(', '),
		catalog_number: release.labels && release.labels[0].catno,
		source: 'discogs'
	}

	db.insert(media);
}

// get a database entry by discogs release_id
const getMediaItem = async (release_id) => {
	const mediaItem = await db.query(`SELECT * FROM media WHERE release_id=${release_id} LIMIT 1`);
	return mediaItem;
}

module.exports = app;
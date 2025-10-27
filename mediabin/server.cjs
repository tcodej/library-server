const express = require('express');
const mcache = require('memory-cache');
const chalk = require('chalk');
const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const fs = require('fs');
const path = require('path');
const https = require('https');
const db = require('./db.cjs');

const app = express();

// 24 hours
const ttl = 1440;

// use for debugging
const disableCache = true;

// requires dotenv in index.cjs to populate this
const { DISCOGS_TOKEN, DISCOGS_USERNAME } = process.env;
const API_ROOT = '';
const discogsAPI = 'https://api.discogs.com';

const log = (str) => {
	const color = chalk.hex('#88FBFF');
	console.log(color('[Mediabin] '+ str));
}

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
app.get(API_ROOT +'/discogs/import/:id/:type?', (req, res) => {
	const { id, type } = req.params;
	const url = `${discogsAPI}/releases/${id}?token=${DISCOGS_TOKEN}`;

	(async () => {
		const response = await fetch(url, {
			method: 'GET',
			headers: { 'Content-Type': 'application/json' }
		});

		const resp = await response.json();
		let message = '';

		if (!type) {
			const row = await saveRelease(resp);
			saveCover(resp);

			if (row && row.ok) {
				message = 'Release saved.';
			}

		} else if (type === 'image') {
			saveCover(resp, true);
			message = 'Cover image saved.';

		} else if (type === 'preview') {
			// return discogs data without saving to the database
			console.log(resp);
		}

		res.json({
			ok: message ? true : false,
			message: message,
			response: resp
		});
	})();
});


// return a discogs release or master record
// type: releases|masters
app.get(API_ROOT +'/discogs/:type/:id', (req, res) => {
	const { type, id } = req.params;
	const url = `${discogsAPI}/${type}/${id}?token=${DISCOGS_TOKEN}`;

	(async () => {
		let resp = {};

		try {
			const response = await fetch(url, {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' }
			});

			resp = await response.json();

			if (type === 'releases') {
				// check to see if a cover image needs to be downloaded
				saveCover(resp);
			}

		} catch(err) {
			resp = {
				ok: false,
				error: true,
				message: `Discogs ${type} API failed`
			}
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
	const notwantlist = 'wantlist=0';

	(async () => {
		switch (req.params.type) {
			// release by database id
			case 'release':
				sql = `${select} WHERE id=${req.params.id}`;
				msg = 'Release loaded';
			break;
			// all media
			case 'media':
				sql = `${select} WHERE ${notwantlist} ${orderBy}`;
				msg = 'Media list loaded.';
			break;
			case 'collection':
				sql = `${select} WHERE collection_id=${req.params.id} AND ${notwantlist} ${orderBy}`;
				msg = 'Collection loaded.';
			break;
			case 'collections':
				sql = 'SELECT * FROM collections ORDER BY label ASC';
				msg = 'Collections loaded.';
			break;
			case 'dupes':
				sql = 'SELECT * FROM (SELECT *, COUNT(*) OVER (PARTITION BY title) AS dupes FROM media) AS items WHERE items.dupes > 1';
				msg = 'Dupe search complete.';
			break;
			// Items that I don't currently own but want to find
			case 'wantlist':
				sql = `${select} WHERE wantlist=1`;
				msg = 'Wantlist loaded.';
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

app.post(API_ROOT +'/updateReleaseCollection/:id', (req, res) => {
	getMediaItem(req.params.id).then(item => {
		db.update(item.id, req.body).then(row => {
			let message = '';

			if (row) {
				message = 'Release saved.';
			}

			res.json({
				message: message,
				result: row
			});
		});
	});
});

app.post(API_ROOT +'/updateWantlist/:id', (req, res) => {
	getMediaItem(req.params.id).then(item => {
		db.update(item.id, req.body).then(row => {
			let message = '';

			if (row) {
				message = 'Wantlist saved.';
			}

			res.json({
				message: message,
				result: row
			});
		});
	});
});

app.post(API_ROOT +'/delete/:id', (req, res) => {
	(async () => {
		const { id } = req.params;

		try {
			const item = await getMediaItem(id);

			if (item?.cover) {
				const respCover = await deleteCover(item.cover);
			}

			const resp = await db.query(`DELETE FROM media WHERE id=${id}`);

			res.json({
				message: 'Media deleted.',
				response: resp,
				result: []
			});

		} catch (err) {
			log(err);
			res.status(500).json({
				message: err.sqlMessage || 'Database error',
				result: []
			});
		}
	})();
});

app.post(API_ROOT +'/verify/:id', (req, res) => {
	(async () => {
		const { id } = req.params;

		try {
			db.update(id, { date_verified: now() }).then(row => {
				let message = '';

				if (row) {
					message = 'Verified.';
				}

				res.json({
					message: message,
					result: row
				});
			});

		} catch (err) {
			log(err);
			res.status(500).json({
				message: err.sqlMessage || 'Database error',
				result: []
			});
		}
	})();
});


log('MediaBin Server is available.');
log(`Cache is ${disableCache ? 'disabled' : 'enabled'}`);



const addSlashes = (str) => {
	if (!str) {
		return '';
	}

	return str.replace(/\\/g, '\\\\')
		.replace(/\u0008/g, '\\b')
		.replace(/\t/g, '\\t')
		.replace(/\n/g, '\\n')
		.replace(/\f/g, '\\f')
		.replace(/\r/g, '\\r')
		.replace(/'/g, '\\\'')
		.replace(/"/g, '\\"');
}

const saveCover = (release, forceSave) => {
	let imageURL;
	const dirPath = __dirname +'/files/covers';
	const fileName = `${release.id}.jpg`;
	const filePath = path.join(dirPath, fileName);

	if (release.images && release.images.length > 0) {
		imageURL = release.images[0].uri150;
	}

	if (release.id) {
		getMediaItem(release.id).then(item => {
			// only save if the item doesn't already have a cover image
			if ((!item.cover && imageURL) || forceSave === true) {
				const file = fs.createWriteStream(filePath);

				https.get(imageURL, response => {
					response.pipe(file);

					file.on('finish', () => {
						file.close();
						log(`Image downloaded as ${fileName}`);
						db.update(item.id, { cover: fileName });
					});

				}).on('error', err => {
					fs.unlink(filePath);
					console.error(`Error downloading image: ${err.message}`);
				});
			}
		});

	} else {
		log('No release_id');
	}
}

const deleteCover = async (fileName) => {
	log(fileName);
	const dirPath = __dirname +'/files/covers';
	const filePath = path.join(dirPath, fileName);

	fs.unlink(filePath, (err) => {
		if (err) {
			// fail silently
			log(`Failed to delete file ${fileName}`);

		} else {
			log(`Deleted file ${fileName}`);
		}
	});
}

const saveRelease = async (release) => {
	log(`Saving ${release.id} to the database.`);
	let media = {
		artist: release.artists && addSlashes(release.artists[0].name),
		title: addSlashes(release.title),
		released: release.released || release.year,
		label: release.labels && addSlashes(release.labels[0].name),
		release_id: release.id,
		format: addSlashes(release.formats[0].name +', '+ release.formats[0].descriptions.join(', ')),
		catalog_number: release.labels && release.labels[0].catno,
		source: 'discogs'
	}

	const row = await db.insert(media);
	return {
		ok: (row && row.insertId) ? true : false,
		response: row
	}
}

const updateMedia = async (release) => {
	log(`Saving ${release.id} to the database.`);
	let media = {
		artist: release.artists && addSlashes(release.artists[0].name),
		title: addSlashes(release.title),
		released: release.released || release.year,
		label: release.labels && addSlashes(release.labels[0].name),
		release_id: release.id,
		format: addSlashes(release.formats[0].name +', '+ release.formats[0].descriptions.join(', ')),
		catalog_number: release.labels && release.labels[0].catno,
		source: 'discogs'
	}

	const row = await db.insert(media);
	return {
		ok: (row && row.insertId) ? true : false,
		response: row
	}
}

// get a database entry by discogs release_id
const getMediaItem = async (release_id) => {
	const mediaItem = await db.query(`SELECT * FROM media WHERE release_id=${release_id} LIMIT 1`);
	return mediaItem;
}

// formad current date as a TIMESTAMP field value
const now = () => {
	let date = new Date();

	date = date.getUTCFullYear() + '-' +
		('00' + (date.getUTCMonth()+1)).slice(-2) +'-'+
		('00' + date.getUTCDate()).slice(-2) +' '+ 
		('00' + date.getUTCHours()).slice(-2) +':'+ 
		('00' + date.getUTCMinutes()).slice(-2) +':'+ 
		('00' + date.getUTCSeconds()).slice(-2);

	return date;
}

module.exports = app;
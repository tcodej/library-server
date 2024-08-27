const express = require('express');
const mcache = require('memory-cache');
const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const fs = require('fs');
const path = require('path');
const https = require('https');
const Jimp = require('jimp');
const db = require('./db.cjs');
const utils = require('../utils.cjs');

const app = express();

// 24 hours
const ttl = 1440;

// use for debugging
const disableCache = false;

const API_ROOT = '';

const cache = (duration) => {
	return (req, res, next) => {
		const key = 'assetbin-server-'+ req.originalUrl || req.url;
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
	res.send('AssetBin Server v1.0');
});

// utility endpoint to aid in troubleshooting
app.get(API_ROOT +'/cache/clear', (req, res) => {
	mcache.clear();
	res.send({ message: 'Cache cleared' });
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
		q = utils.addSlashes(req.query.q);
		sql = `SELECT * FROM assets WHERE `;

		['name', 'part_number'].forEach((column) => {
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

// id is only used for type release or category
app.get(API_ROOT +'/feed/:type/:id?', (req, res) => {
	let sql = '';
	let msg = '';
	const select = 'SELECT * FROM assets';
	const orderBy = 'ORDER BY name ASC';

	(async () => {
		switch (req.params.type) {
			// asset by database id
			case 'asset':
				sql = `${select} WHERE id=${req.params.id}`;
				msg = 'Asset loaded';
			break;
			// all assets
			case 'assets':
				sql = `SELECT assets.*, categories.name AS category, locations.name as location FROM assets
LEFT JOIN categories ON assets.category_id=categories.id
LEFT JOIN locations ON assets.location_id=locations.id ${orderBy}`;
				msg = 'Asset list loaded.';
			break;
			case 'category':
				sql = `${select} WHERE category_id=${req.params.id} ${orderBy}`;
				msg = 'Category assets loaded.';
			break;
			case 'categories':
				sql = 'SELECT * FROM categories ORDER BY name ASC';
				msg = 'Categories loaded.';
			break;
			case 'locations':
				sql = 'SELECT * FROM locations ORDER BY name ASC';
				msg = 'Locations loaded.';
			break;
		}

		try {
			const resp = await db.query(sql);

			res.json({
				message: msg,
				result: resp,
				total: resp.length
			});

		} catch (err) {
			res.status(500).json({
				message: 'Database error',
				result: []
			});
		}
	})();
});

app.post(API_ROOT +'/update/:id?', (req, res) => {
	// if id is present, it's an update, otherwise insert new
	// console.log('--- update', req.body);

	(async () => {
		let image_data = false;

		if (req.body.image_data) {
			image_data = req.body.image_data;
			delete req.body.image_data;
		}

		if (req.body.id) {
			db.update(req.body.id, req.body).then(row => {
				let message = '';

				if (row) {
					message = 'Asset updated';

					if (image_data) {
						savePhoto(image_data, req.body.id);
					}
				}

				res.json({
					message: message,
					result: row
				});
			});

		} else {
			const row = await db.insert(req.body);

			if (image_data && row.insertId) {
				savePhoto(image_data, row.insertId);
			}

			res.json({
				ok: (row && row.insertId) ? true : false,
				message: 'Asset created',
				response: row
			});
		}
	})();
});

const savePhoto = (image_data, id) => {
	if (!id) {
		console.log('id required to save photo');
		return;
	}

	const [ type, data ] = image_data.split(',');
	const now = new Date();
	const dirPath = __dirname +'/files/photos';
	const fileName = `${id}_${now.getTime()}.jpg`;
	const filePath = path.join(dirPath, fileName);
	const buffer = Buffer.from(data, 'base64');

	Jimp.read(buffer, (err, res) => {
		if (err) throw new Error(err);
		res
			.cover(640, 480)
			.quality(80)
			.write(filePath);
		db.update(id, { photo: fileName });
	});
}


console.log('AssetBin Server is available.');
console.log(`Cache is ${disableCache ? 'disabled' : 'enabled'}`);

module.exports = app;
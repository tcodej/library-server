const express = require('express');
const chalk = require('chalk');
const db = require('./db.cjs');

const app = express();
const API_ROOT = '';

const log = (str) => {
	const color = chalk.hex('#00C020');
	console.log(color('[Messagebin] '+ str));
}

app.get('/', (req, res) => {
	res.send('CodeBin Server v1.0');
});

// id is only used for type release or category
app.get(API_ROOT +'/feed/:type/:id?', (req, res) => {
	let sql = '';
	let msg = '';
	const select = 'SELECT * FROM messages';
	const orderBy = 'ORDER BY name ASC';

	(async () => {
		switch (req.params.type) {
			// message by database id
			case 'message':
				sql = `${select} WHERE id=${req.params.id}`;
				msg = 'Messages loaded';
			break;
			// message by slug
			case 'slug':
				sql = `${select} WHERE slug='${req.params.id}'`;
				msg = 'Message loaded';
			break;
			// all messages
			case 'messages':
				sql = select;
				msg = 'Message list loaded.';
			break;
		}

		try {
			const resp = await db.query(sql);
			const rows = resp.length ? resp : [resp];

			res.json({
				message: msg,
				result: rows,
				total: rows.length
			});

		} catch (err) {
			res.status(500).json({
				message: err,
				result: []
			});
		}
	})();
});

// if id is present, it's an update, otherwise insert a new row
app.post(API_ROOT +'/update/:id?', (req, res) => {
	// log('--- update', req.body);

	(async () => {
		if (req.body.id) {
			db.update(req.body.id, req.body).then(row => {
				let message = '';

				if (row) {
					message = 'Message updated';
				}

				res.json({
					message: message,
					result: row
				});
			});

		} else {
			const row = await db.insert(req.body);

			res.json({
				ok: (row && row.insertId) ? true : false,
				message: 'Message created',
				response: row
			});
		}
	})();
});

app.get(API_ROOT +'/delete/:id', (req, res) => {
	(async () => {
		try {
			const resp = await db.delete(req.params.id);

			res.json({
				message: 'Message deleted.',
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

log('CodeBin Server is available.');

module.exports = app;
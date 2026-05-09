const express = require('express');
const chalk = require('chalk');
const db = require('./db.cjs');

const app = express();
const API_ROOT = '';

const log = (str) => {
	const color = chalk.hex('#00C020');
	console.log(color('[TaskBin] '+ str));
}

app.get('/', (req, res) => {
	res.send('TaskBin Server v1.0');
});

// id is only used for type release or category
app.get(API_ROOT +'/feed/:type/:id?', (req, res) => {
	let sql = '';
	let msg = '';
	const select = 'SELECT * FROM lists';

	(async () => {
		switch (req.params.type) {
			// message by database id
			case 'message':
				sql = `${select} WHERE id=${req.params.id}`;
				msg = 'List loaded';
			break;
			// all lists
			case 'lists':
				sql = select;
				msg = 'Lists loaded.';
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
	const data = JSON.stringify(req.body);

	(async () => {
		if (req.params.id) {
			db.update(req.params.id, data).then(row => {
				let message = '';

				if (row) {
					message = 'List updated';
				}

				res.json({
					message: message,
					result: row
				});
			});

		} else {
			const row = await db.insert(data);

			res.json({
				ok: (row && row.insertId) ? true : false,
				message: 'List created',
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
				message: 'List deleted.',
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

log('TaskBin Server is available.');

module.exports = app;
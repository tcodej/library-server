const express = require('express');
const db = require('./db.cjs');

const app = express();

// requires dotenv in index.cjs to populate this
const { PROTOCOL, PORT } = process.env;
const API_ROOT = '';

app.get('/', (req, res) => {
	res.send('Tracker Server v1.0');
});

app.get(API_ROOT +'/locations/:type/:id?', (req, res) => {
	let sql = '';
	let msg = '';
	const { type, id } = req.params;

	(async () => {
		switch (type) {
			case 'history':
				sql = `SELECT * FROM locations ORDER BY date DESC LIMIT 30`;
				msg = 'Locations loaded.';
			break;
			case 'recent':
				sql = `SELECT * FROM locations ORDER BY date DESC LIMIT 1`;
				msg = 'Recent location loaded.';
			break;
			case 'notes':
				sql = `SELECT * FROM locations WHERE note_value IS NOT NULL ORDER BY date DESC`;
				msg = 'Locations with notes loaded.';
			break;
			case 'get':
				sql = `SELECT * FROM locations WHERE id=${id} LIMIT 1`;
				msg = 'Location loaded.';
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

app.post(API_ROOT +'/saveLocation', (req, res) => {
	(async () => {
		const row = await saveLocation(req.body);

		let message = '';

		if (row && row.ok) {
			message = 'Location saved.';
		}

		res.json({
			ok: message ? true : false,
			message: message,
			response: row.response
		});
	})();
});

app.post(API_ROOT +'/deleteLocation', (req, res) => {
	(async () => {
		console.log(req.body);
		const { id } = req.body;
		const row = await db.delete(id);

		let message = '';

		// todo: this isn't valid
		if (row && row.ok) {
			message = 'Location deleted.';
		}

		res.json({
			ok: message ? true : false,
			message: message,
			response: row.response
		});
	})();
});

app.post(API_ROOT +'/saveNote', (req, res) => {
	(async () => {
		const row = await db.update(req.body);

		let message = '';

		if (row && row.ok) {
			message = 'Location saved.';
		}

		res.json({
			ok: message ? true : false,
			message: message,
			response: row.response
		});
	})();
});



console.log('Tracker Server is available.');


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

const saveLocation = async (data) => {
	console.log(`Saving location to the database.`);

	const row = await db.insert(data);

	return {
		ok: (row && row.insertId) ? true : false,
		response: row
	}
}


module.exports = app;
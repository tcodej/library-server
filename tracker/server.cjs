const express = require('express');
const db = require('./db.cjs');
const fs = require('fs');
const p = require('path');
const chalk = require('chalk');

const app = express();

// requires dotenv in index.cjs to populate this
const { PROTOCOL, PORT } = process.env;
const API_ROOT = '';

const log = (str) => {
	const color = chalk.hex('#207581');
	console.log(color('[Tracker] '+ str));
}

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

app.get(API_ROOT +'/routes/get', (req, res) => {
	try {
		const list = fs.readdirSync(__dirname +'/files/gpx');
		let response = {
			message: '',
			result: [],
			total: 0
		};

		// Cycle-20120718-1941-53950.gpx
		list.forEach((item) => {
			const [type, date, time] = item.split('-');
			// type - date - time - ?
			let data = {
				type: type.toLowerCase(),
				datetime: date.substr(0, 4) +'-'+ date.substr(4, 2) +'-'+ date.substr(6, 2) +'T'+ time.substr(0, 2) +':'+ time.substr(2, 2),
				file: item
			}

			response.result.push(data);
		});

		sort(response.result, 'datetime', 'desc');
		response.total = response.result.length;
		response.message = 'Routes loaded.';

		res.json(response);

	} catch (err) {
		log(err);
		res.status(404).json({
			ok: false,
			error: err.message
		});
	}
});


log('Tracker Server is available.');


const saveLocation = async (data) => {
	log(`Saving location to the database.`);

	const row = await db.insert(data);

	return {
		ok: (row && row.insertId) ? true : false,
		response: row
	}
}

/**
 * Helper function to sort an array of objects by chosen key
 */
const sort = (arr, key, dir) => {
    try {
        arr.sort(function(a, b) {
            if (key) {
                a = a[key];
                b = b[key];
            }

            if (dir === 'desc') {
	            if (a.toLowerCase() < b.toLowerCase()) {
	                return 1;
	            }

	            if (a.toLowerCase() > b.toLowerCase()) {
	                return -1;
	            }

            } else {
	            if (a.toLowerCase() < b.toLowerCase()) {
	                return -1;
	            }

	            if (a.toLowerCase() > b.toLowerCase()) {
	                return 1;
	            }
	        }

            return 0;
        });

        return arr;

    } catch (err) {
        log('sort failed', arr, key);
    }
}



module.exports = app;
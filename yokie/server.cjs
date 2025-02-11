const express = require('express');
const chalk = require('chalk');
const db = require('./db.cjs');
const utils = require('../utils.cjs');

const app = express();

// requires dotenv in index.cjs to populate this
const { PROTOCOL, PORT, CDG_PATH } = process.env;
const API_ROOT = '';

const log = (str) => {
	const color = chalk.hex('#E3E700');
	console.log(color('[Yokie] '+ str));
}

app.get('/', (req, res) => {
	res.send('Yokie Server v1.0');
});

app.get(API_ROOT +'/feed/preferences', (req, res) => {
	let result;

	(async () => {
		const prefs = await db.query(`SELECT * FROM preferences`);
		const songs = await db.query(`SELECT COUNT(*) AS total FROM songs`);
		const [ whatsNewDate, hue, saturation, lightness, remoteAddEnabled, chatEnabled, siteEnabled ] = prefs;
		result = {
			status: 'ok',
			message: 'Preferences loaded.',
			preferences: {
				whatsNewDate: whatsNewDate.value,
				hue: hue.value,
				saturation: saturation.value,
				lightness: lightness.value,
				remoteAddEnabled: remoteAddEnabled.value,
				chatEnabled: chatEnabled.value,
				siteEnabled: siteEnabled.value,
				totalSongs: songs.total
			}
		}

		res.json(result);
	})();
});

app.post(API_ROOT +'/search', (req, res) => {
	let q = '';
	let sql = '';
	let msg = '';
	let data = '';

/*
	// fulltext search
	if (req.body && req.body.query) {
		q = req.body.query;
		// strip out non-alpuanumeric chars leaving spaces
		q = q.replace(/[^a-z0-9 ]/gi, '');

		// spaces in search?
		if (q.indexOf(' ') > -1) {
			q = q.replaceAll(' ', '* +');
			q = '+'+ q +'*';

		} else {
			q = q +'*';
		}

		sql = `SELECT * FROM songs WHERE MATCH (artist,title) AGAINST (? IN BOOLEAN MODE) ORDER BY artist,title ASC`;
		data = [q];
		msg = 'Search complete.';

	} else {
		msg = 'Search query query.';
	}
*/
	// default search
	if (req.body && req.body.query) {
		let sqlArr = [];
		let terms = [];

		// escape characters
		q = utils.addSlashes(req.body.query);
		sql = `SELECT * FROM songs WHERE `;

		['artist', 'title'].forEach((column) => {
			q.split(' ').forEach((keyword) => {
				terms.push(`${column} LIKE '%${keyword}%'`);
			});

			sqlArr.push('('+ terms.join(' AND ') +')');
			terms = [];
		});

		sql += sqlArr.join(' OR ');

		// somewhat ordered by relevance
		// alnum() is a stored procedure
		// see http://www.rummandba.com/2011/02/mysql-function-to-remove-non.html

		sql += ` ORDER BY CASE WHEN alnum(artist) LIKE '${q}%' THEN 0`;
		sql += ` WHEN alnum(artist) LIKE '${q} %' THEN 1`;
		sql += ` WHEN alnum(artist) LIKE '% ${q} %' THEN 2`;
		sql += ` WHEN alnum(artist) LIKE '%${q}%' THEN 3`;
		sql += ` ELSE 4 END, title`;

	} else {
		msg = 'Search query missing.';
	}

	(async () => {
		let resp = await db.query(sql, data);

		res.json({
			message: msg,
			result: resp,
			total: resp.length
		});
	})();
});

app.post(API_ROOT +'/feed/:type', (req, res) => {
	let sql = '';
	let msg = '';
	let data = '';

	(async () => {
		switch (req.params.type) {
			// Returns a list of singers from the singers table, with optional stats when used in the singers view in the queue panel
			case 'singers':
				sql = `SELECT * FROM singers ORDER BY name ASC`;
				msg = 'Singers loaded.';
			break;

			// Returns a list of songs and stats based on a singer id
			case 'singer-log':
				sql = `SELECT queue_log.name, queue_log.type, songs.*, queue_log.created, COUNT(*) AS count FROM queue_log, songs WHERE queue_log.song_id = songs.id and queue_log.singer_id = ? GROUP BY queue_log.name, songs.title ORDER BY queue_log.singer_id ASC, count DESC`;
				data = [req.body.id];
				msg = 'Singers loaded.';
			break;

			// Return all songs (for the booklet view)
			case 'all':
				sql = `SELECT id, artist, title FROM songs ORDER BY artist ASC`;
				msg = 'All songs loaded.';
			break;

			// Return 20 random songs
			case 'random':
				sql = `SELECT * FROM songs ORDER BY RAND() ASC LIMIT 20`;
				msg = 'Random songs complete.';
			break;

			// Return songs added since the last whatsNewDate in preferences
			case 'newest':
				const date = await db.query(`SELECT value FROM preferences WHERE name=?`, ['whatsNewDate']);
				if (date.value) {
					sql = `SELECT * FROM songs WHERE (date_added >= ?) ORDER BY artist,title ASC`;
					data = [date.value];
					msg = 'New songs found.';
				}
			break;

			// Return songs with most number of plays
			case 'popular':
				sql = `SELECT * FROM songs ORDER BY plays DESC LIMIT 100`;
				msg = 'Popular songs found.';
			break;

			// Return tags for a chosen song
			case 'song-tags':
				sql = `SELECT tag_id AS id, tag_name AS name FROM songs_merged WHERE id=?`;
				data = [req.body.id];
				msg = 'Song tags loaded.';
			break;

			// Return songs that have the chosen tag
			case 'search-tag':
				sql = `SELECT * FROM songs_merged WHERE tag_id=? ORDER BY artist ASC`;
				data = [req.body.id];
				msg = 'Tag search complete.';
			break;

			// Return all tags
			case 'tags':
				sql = `SELECT * FROM tags`;
				msg = 'Tags loaded.';
			break;

			// Return songs with notes
			case 'notes':
				sql = `SELECT * FROM songs WHERE (note != '') ORDER BY artist,title ASC`;
				msg = 'Songs with notes loaded.';
			break;
		}

		const resp = await db.query(sql, data);

		res.json({
			message: msg,
			result: resp,
			total: resp.length
		});
	})();
});

app.get(API_ROOT +'/queue/get', (req, res) => {
	(async () => {
		const queue = await db.query(`SELECT queue.*, songs.artist, songs.title, songs.path FROM queue LEFT JOIN songs ON queue.song_id=songs.id ORDER BY ordinal ASC`);

		queue.forEach((item) => {
			if (item.youtube) {
				item.song = {
					artist: '',
					title: item.custom_title,
					path: item.custom_path
				}

			} else {
				item.song = {
					artist: item.artist,
					title: item.title,
					// todo: let the front-end format this
					path: `${PROTOCOL}://${req.hostname}:${PORT}${API_ROOT}/api/yokie/cdg/`+ item.path
				}
			}
		});

		res.json({
			result: queue
		});
	})();
});

app.get(API_ROOT +'/queue/add', (req, res) => {
	res.json({ ok: true });
});

app.post(API_ROOT +'/queue/remove', (req, res) => {
	(async () => {
		const { id } = req.params;
		console.log(req); return;
		const row = await db.delete(id);

		let message = '';

		// todo: this isn't valid
		if (row && row.ok) {
			message = 'Queue slot deleted.';
		}

		res.json({
			ok: message ? true : false,
			message: message,
			response: row.response
		});
	})();
});

log('Yokie Server is available.');
log(`CDG_PATH is ${CDG_PATH}`);

module.exports = app;
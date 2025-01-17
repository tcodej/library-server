const mysql = require('mysql2/promise');
const utils = require('../utils.cjs');

// requires dotenv in index.cjs to populate this
const { DB_HOST, DB_USER_CODEBIN, DB_PASSWORD_CODEBIN, DB_DATABASE_CODEBIN } = process.env;

const openConnection = async () => {
	const db = await mysql.createConnection({
		host: DB_HOST,
		user: DB_USER_CODEBIN,
		password: DB_PASSWORD_CODEBIN,
		database: DB_DATABASE_CODEBIN,
		// don't convert YYYY-MM-DD to YYYY-MM-DDT07:00:00.000Z
		dateStrings: true
	});

	return db;
}

exports.query = async (statement, data) => {
	const db = await openConnection();
	let rows = [];
	let fields = [];

	if (Array.isArray(data)) {
		// prepared statement
		const sql = db.format(statement, data);
		// console.log(sql);
		[rows, fields] = await db.execute(sql);

	} else {
		// console.log(statement);
		[rows, fields] = await db.execute(statement);
	}

	await db.end();

	return rows.length === 1 ? rows[0] : rows;
}

exports.update = async (id, data) => {
	const db = await openConnection();
	let rows = [];
	let updates = [];

	for (const [key, value] of Object.entries(data)) {
		updates.push(`${key}='${utils.addSlashes(value)}'`);
	}

	const sql = db.format(`UPDATE messages SET ${updates.join(',')} WHERE id=${id}`);

	if (id) {
		[rows] = await db.execute(sql);

	} else {
		console.log('No id for db update');
	}

	await db.end();

	return rows.length === 1 ? rows[0] : rows;
}

exports.insert = async (data) => {
	const db = await openConnection();
	let resp = {};
	let inserts = [];
	let values = []
	let sql = 'INSERT INTO messages ';

	for (const [key, value] of Object.entries(data)) {
		inserts.push(key);
		values.push(`'${utils.addSlashes(value)}'`);
	}

	sql += `(${inserts.join(', ')}) VALUES (${values.join(', ')})`;

	const statement = db.format(sql);
	[resp] = await db.execute(statement);
	await db.end();

	return resp;
}

exports.delete = async (id) => {
	
}


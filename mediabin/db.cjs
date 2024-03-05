const mysql = require('mysql2/promise');

// requires dotenv in index.cjs to populate this
const { DB_HOST, DB_USER_MEDIABIN, DB_PASSWORD_MEDIABIN, DB_DATABASE_MEDIABIN } = process.env;

const openConnection = async () => {
	const db = await mysql.createConnection({
		host: DB_HOST,
		user: DB_USER_MEDIABIN,
		password: DB_PASSWORD_MEDIABIN,
		database: DB_DATABASE_MEDIABIN,
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

exports.update = async (data) => {
	const db = await openConnection();
	let rows = [];
	const sql = db.format(`UPDATE media SET cover='${data.cover}' WHERE id=${data.id}`);

	if (data.id) {
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
	let sql = 'INSERT INTO media ';

	for (const [key, value] of Object.entries(data)) {
		inserts.push(key);
		values.push(`'${value}'`);
	}

	sql += `(${inserts.join(', ')}) VALUES (${values.join(', ')})`;

	const statement = db.format(sql);
	[resp] = await db.execute(statement);
	await db.end();

	return resp;
}


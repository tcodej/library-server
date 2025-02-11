const mysql = require('mysql2/promise');

const { DB_HOST, DB_USER_YOKIE, DB_PASSWORD_YOKIE, DB_DATABASE_YOKIE } = process.env;

const openConnection = async () => {
	const db = await mysql.createConnection({
		host: DB_HOST,
		user: DB_USER_YOKIE,
		password: DB_PASSWORD_YOKIE,
		database: DB_DATABASE_YOKIE,
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

// exports.update = async (data) => {
// 	const db = await openConnection();
// 	let rows = [];
// 	const sql = db.format(`UPDATE locations SET note_type='${data.note_type}', note_value='${data.note_value}' WHERE id=${data.id}`);

// 	if (data.id) {
// 		[rows] = await db.execute(sql);

// 	} else {
// 		console.log('No id for db update');
// 	}

// 	await db.end();

// 	return rows.length === 1 ? rows[0] : rows;
// }

// exports.insert = async (data) => {
// 	const db = await openConnection();
// 	let resp = {};
// 	let inserts = [];
// 	let values = []
// 	let sql = 'INSERT INTO locations ';

// 	for (const [key, value] of Object.entries(data)) {
// 		inserts.push(key);
// 		values.push(`'${value}'`);
// 	}

// 	sql += `(${inserts.join(', ')}) VALUES (${values.join(', ')})`;

// 	const statement = db.format(sql);
// 	[resp] = await db.execute(statement);
// 	await db.end();

// 	return resp;
// }

exports.delete = async (id) => {
	const db = await openConnection();
	let resp = {};
	let sql = `DELETE FROM queue WHERE id=${id}`;

	const statement = db.format(sql);
	[resp] = await db.execute(statement);
	await db.end();

	return resp;
}

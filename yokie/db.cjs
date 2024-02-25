const mysql = require('mysql2/promise');

const { DB_HOST, DB_USER_YOKIE, DB_PASSWORD_YOKIE, DB_DATABASE_YOKIE } = process.env;

exports.query = async (statement, data) => {
	const db = await mysql.createConnection({
		host: DB_HOST,
		user: DB_USER_YOKIE,
		password: DB_PASSWORD_YOKIE,
		database: DB_DATABASE_YOKIE,
		// don't convert YYYY-MM-DD to YYYY-MM-DDT07:00:00.000Z
		dateStrings: true
	});

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

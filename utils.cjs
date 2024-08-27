// shared utilities

exports.addSlashes = (str) => {
	if (typeof str !== 'string') {
		return str;
	}

	return str.replace(/\\/g, '\\\\')
		.replace(/\u0008/g, '\\b')
		.replace(/\t/g, '\\t')
		.replace(/\n/g, '\\n')
		.replace(/\f/g, '\\f')
		.replace(/\r/g, '\\r')
		.replace(/'/g, '\\\'')
		.replace(/"/g, '\\"');
}
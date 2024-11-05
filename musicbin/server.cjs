const express = require('express');
const fs = require('fs');
const p = require('path');
const mcache = require('memory-cache');
const chalk = require('chalk');

let mm;

(async () => {
	mm = await import('music-metadata');
})(mm);

// const mm = require('music-metadata');

const app = express();
const API_ROOT = '';

// 5 minutes
const ttl = 300;

// use for debugging
const disableCache = false;

// requires dotenv in index.cjs to populate this
const { MP3_PATH, CDG_PATH, PROTOCOL, HOST } = process.env;

const log = (str) => {
	const color = chalk.hex('#2776FF');
	console.log(color('[Musicbin] '+ str));
}

const cache = (duration) => {
	return (req, res, next) => {
		const key = 'musicbin-server-'+ req.originalUrl || req.url;
		const cachedBody = mcache.get(key);

		if (cachedBody && !disableCache) {
			res.send(cachedBody);
			return;

		} else {
			res.sendResponse = res.send;
			res.send = (body) => {
				mcache.put(key, body, duration * 1000);
				res.sendResponse(body);
			}

			next();
		}
	}
}

app.get('/', (req, res) => {
	res.send('MusicBin Server v1.0');
});

// utility endpoint to aid in troubleshooting
app.get(API_ROOT +'/cache/clear', (req, res) => {
	mcache.clear();
	res.send({ message: 'Cache cleared' });
});

// memory cache stats
app.get(API_ROOT +'/cache/stats', (req, res) => {
	const result = {
		message: 'Stats loaded',
		size: mcache.size(),
		memsize: mcache.memsize(),
		hits: mcache.hits(),
		misses: mcache.misses()
	};

	res.send(result);
});

app.get(API_ROOT +'/browse/*', cache(ttl), (req, res) => {
	const pathReq = decodeURIComponent(req.params[0]);

	try {
		const list = fs.readdirSync(p.join(MP3_PATH, pathReq));
		let result = {
			path: req.params[0],
			folders: [],
			albums: [],
			files: [],
			unsupported: []
		}

		list.forEach((item) => {
			if (isDir(p.join(MP3_PATH, pathReq, item))) {
				result.folders.push(item);

			} else {
				if (isMusicFile(item)) {
					result.files.push(item);

				} else {
					result.unsupported.push(item);
				}
			}
		});

		(async () => {
			// if browsing an album folder, return a subset of metadata based on the first file
			if (result.files.length > 0) {
				const meta = await getMeta(p.join(result.path, result.files[0]), true);

				if (meta.ok) {
					result.meta = meta;
				}
			}

			// if album folders are found, check for available meta data if music files are inside
			if (pathReq && result.folders.length > 0) {
				for await (const album of result.folders) {
					const fileList = fs.readdirSync(p.join(MP3_PATH, pathReq, album));
					let found = false;
					let cover = '';

					// look for the first valid music file to grab meta data from
					for (let i=0; i<fileList.length; i++) {
						// cover.jpg or folder.jpg - only supported folders with no music files
						if (['cover.jpg', 'folder.jpg'].includes(fileList[i])) {
							cover = getURL(req, p.join(pathReq, album, fileList[i]));
							found = true;

							result.albums.push({
								isFolder: true,
								artist: pathReq,
								path: p.join(pathReq, album),
								image: cover
							});

						} else {
							if (isMusicFile(fileList[i])) {
								const meta = await getMeta(p.join(pathReq, album, fileList[i]), true);

								if (meta.ok) {
									meta.path = p.join(pathReq, album);
									result.albums.push(meta);
								}

								found = true;
								break;
							}
						}
					}
				}
			}

			// log(result);
			res.json(result);
		})();

	} catch (err) {
		log(err);
		res.status(404).json({
			ok: false,
			error: err.message
		});
	}
});

// expects a path to folder containing at least 1 mp3 file
app.get(API_ROOT +'/meta/folder/*', cache(ttl), (req, res) => {
	const pathReq = decodeURIComponent(req.params[0]);

	try {
		const list = fs.readdirSync(p.join(MP3_PATH, pathReq));
		let found = false;
		let cover = '';

		// look for the first valid music file to grab meta data from
		for (let i=0; i<list.length; i++) {
			// cover.jpg or folder.jpg - only supported folders with no music files
			if (['cover.jpg', 'folder.jpg'].includes(list[i])) {
				cover = getURL(req, p.join(pathReq, list[i]));
				found = true;
				res.json({
					image: cover
				});

			} else {
				if (isMusicFile(list[i])) {
					(async () => {
						const meta = await getMeta(p.join(pathReq, list[i]), true);

						if (meta.ok) {
							res.json(meta);

						} else {
							res.status(500).json(meta);
						}
					})();

					found = true;
					break;
				}
			}
		}

		if (found === false) {
			res.json({
				ok: false,
				error: 'Folder does not contain a valid music file. No thumbnail available.'
			});
		}

	} catch(err) {
		log(err);
		res.status(500).json({
			ok: false,
			error: err.message
		});
	}
});

// expects a path to an mp3 file
app.get(API_ROOT +'/meta/*', cache(ttl), (req, res) => {
	const pathReq = decodeURIComponent(req.params[0]);

	(async () => {
		const meta = await getMeta(pathReq);
		meta.mp3 = getURL(req, pathReq);

		if (meta.ok) {
			res.json(meta);

		} else {
			res.status(500).json(meta);
		}
	})();
});

// experimental random album picker
app.get(API_ROOT +'/random/albums/:num', (req, res) => {
	// randomize artist folders
	const artists = shuffle(fs.readdirSync(MP3_PATH));
	const result = [];

	(async () => {
		for await (const artist of artists) {
			const itemPath = p.join(MP3_PATH, artist);

			if (isDir(itemPath)) {
				// randomize album folders
				const albumList = shuffle(fs.readdirSync(itemPath));
				// choose the first randomized album folder
				const path = p.join(MP3_PATH, artist, albumList[0]);

				if (isDir(path)) {
					// randomize files inside the folder
					const fileList = shuffle(fs.readdirSync(path));
					// get album meta based on file
					const meta = await getMeta(p.join(artist, albumList[0], fileList[0]), true);

					if (meta.ok) {
						meta.path = p.join(artist, albumList[0]);
						result.push(meta);

						// stop iterating if we've reached our limit
						if (result.length == req.params.num) {
							break;
						}
					}
				}
			} else {
				log('Not a folder: '+ itemPath);
			}
		}

		res.json({ num: req.params.num, result: result });
	})();
});

app.get(API_ROOT +'/random/tracks/:num', (req, res) => {
	(async () => {
		let files = [];

		for await (const f of getMusicFiles(MP3_PATH)) {
			files.push(f.replace(MP3_PATH, ''));
		}

		res.json({
			path: '',
			albums: [],
			files: shuffle(files).slice(0, req.params.num)
		});
	})();
});

// app.listen(PORT, () => {
	log('MusicBin server is available.');
	log(`MP3_PATH is ${MP3_PATH}`);
// });

const shuffle = (arr) => { 
	for (let i = arr.length - 1; i > 0; i--) { 
		const j = Math.floor(Math.random() * (i + 1)); 
		[arr[i], arr[j]] = [arr[j], arr[i]]; 
	}

	return arr; 
}

const getURL = (req, path) => {
	const host = req.header('Host');

	return `${PROTOCOL}://${host}/api/musicbin/mp3/`+ encodeURIComponent(path);
}

const getMeta = async (pathReq, subset) => {
	const filePath = p.join(MP3_PATH, pathReq);

	try {
		if (isMusicFile(filePath)) {
			let { common } = await mm.parseFile(filePath);

			if (common.picture && common.picture[0]) {
				const picture = common.picture[0];

				common.image = `data:${picture.format};base64,${picture.data.toString('base64')}`;
				delete common.picture;
			}

			if (subset === true) {
				const albumMeta = {
					artist: common.artist,
					album: common.album,
					year: common.year,
					image: common.image,
					genre: common.genre
				};

				// override the full common object
				common = albumMeta;
			}

			common.ok = true;
			return common;

		} else {
			log(filePath, 'not a valid music file');
			return {
				ok: false,
				path: filePath,
				error: 'Not a valid music file'
			}
		}

	} catch (err) {
		log(err);
		return {
			ok: false,
			path: filePath,
			error: err.message
		};
	}

	return {
		ok: false,
		path: filePath,
		error: 'Disabled until I can figure out how to make music-metadata work in this context.'
	};
}

// requires a fully qualified path
const isDir = (path) => {
	const stats = fs.lstatSync(path);

	return stats.isDirectory() ? true : false;
}

const isMusicFile = (str) => {
	const formats = ['.mp3', '.m4a'];
	const extension = p.extname(str);

	return extension && formats.includes(extension) ? true : false;
}

// return the entire list of music files recursively from MP3_PATH
async function* getMusicFiles(dir) {
	const items = await fs.promises.readdir(dir, { withFileTypes: true });

	for (const item of items) {
		const res = p.resolve(dir, item.name);

		if (item.isDirectory()) {
			yield* getMusicFiles(res);

		} else {
			if (isMusicFile(item.name)) {
				yield res;
			}
		}
	}
}

module.exports = app;
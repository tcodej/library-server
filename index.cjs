const dotenv = require('dotenv').config();
const express = require('express');
const cors = require('cors');
const favicon = require('serve-favicon');

const musicbin = require('./musicbin/server.cjs');
const mediabin = require('./mediabin/server.cjs');
const yokie = require('./yokie/server.cjs');
const tracker = require('./tracker/server.cjs');
const assetbin = require('./assetbin/server.cjs');

const app = express();

const { CORS_ORIGINS, PROTOCOL, PORT, MP3_PATH, CDG_PATH } = process.env;
const API_ROOT = '/api';

app.use(cors({ origin: CORS_ORIGINS.split(',') }));
app.use(express.json());
app.use(favicon('./favicon.ico'));

app.get('/', (req, res) => {
	res.send('Library Server v1.0');
});

app.get('/healthcheck', (req, res) => {
	res.send({ message: 'I LIVE' });
});

app.get('/coffee', (req, res) => {
	res.status(418).send(`I'm a teapot`);
});

app.listen(PORT, () => {
	console.log(`Library Server listening at ${PROTOCOL}://localhost:${PORT}`);
});





/* ----- CHECKED-IN SERVERS ----- */

const MUSIC_BIN = API_ROOT +'/musicbin';
const MEDIA_BIN = API_ROOT +'/mediabin';
const YOKIE = API_ROOT +'/yokie';
const TRACKER = API_ROOT +'/tracker';
const ASSET_BIN = API_ROOT +'/assetbin';

app.use(MUSIC_BIN, musicbin);
app.use(MUSIC_BIN +'/mp3', express.static(MP3_PATH));

app.use(MEDIA_BIN, mediabin);
app.use(MEDIA_BIN +'/covers', express.static('./mediabin/files/covers'));

app.use(YOKIE, yokie);
app.use(YOKIE +'/cdg', express.static(CDG_PATH));

app.use(TRACKER, tracker);
app.use(TRACKER +'/gpx', express.static('./tracker/files/gpx'));

app.use(ASSET_BIN, assetbin);
app.use(ASSET_BIN +'/pics', express.static('./assetbin/files/pics'));

const http = require('http');

const host = process.env.HOST || 'localhost';
const port = process.env.PORT || 3001;

const options = {
  host: host,
  port: port,
  path: '/health',
  timeout: 2000
};

const request = http.request(options, (res) => {
  process.exit(res.statusCode === 200 ? 0 : 1);
});

request.on('error', () => {
  process.exit(1);
});

request.end();

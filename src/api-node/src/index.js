const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const client = require('prom-client');
const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'secret123',
  database: process.env.DB_NAME || 'mydb',
});

const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ timeout: 5000 });

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello From Node API' });
});

app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.status(200).json({ status: 'healthy', database: 'connected' });
  } catch (error) {
    res.status(200).json({ status: 'healthy', database: 'disconnected' });
  }
});

app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users ORDER BY id');
    res.json({ users: result.rows });
  } catch (error) {
    console.error('Database error:', error.message);
    res.json({ users: [], message: 'Database not connected yet' });
  }
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(PORT, () => {
  console.log(`Node API running on port ${PORT}`);
  console.log(`DB Host: ${process.env.DB_HOST || 'localhost'}`);
});

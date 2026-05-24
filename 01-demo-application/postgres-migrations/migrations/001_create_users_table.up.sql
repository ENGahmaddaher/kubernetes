CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- بيانات تجريبية أولية
INSERT INTO users (name, email) VALUES 
  ('Ali', 'ali@example.com'),
  ('Sara', 'sara@example.com'),
  ('Omar', 'omar@example.com')
ON CONFLICT (email) DO NOTHING;

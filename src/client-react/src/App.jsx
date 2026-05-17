import { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [apiMessage, setApiMessage] = useState('');
  const [users, setUsers] = useState([]);

  useEffect(() => {
    // استخدام مسار نسبي - سيعمل محلياً (مع Vite proxy) وعلى Kubernetes (مع Ingress)
    fetch('/api/hello')
      .then((res) => {
        if (!res.ok) throw new Error('API not ready yet');
        return res.json();
      })
      .then((data) => setApiMessage(data.message))
      .catch((err) => {
        console.log('API will be connected later:', err.message);
        setApiMessage('(API not connected yet)');
      });

    // جلب المستخدمين
    fetch('/api/users')
      .then((res) => {
        if (!res.ok) throw new Error('Users API not ready');
        return res.json();
      })
      .then((data) => setUsers(data.users || []))
      .catch((err) => {
        console.log('Users API will be connected later:', err.message);
      });
  }, []);

  return (
    <div className="app">
      <h1>🚀 Microservices Demo</h1>
      <p>Frontend is running!</p>
      <p className="api-message">
        Message from API: <strong>{apiMessage}</strong>
      </p>
      
      <div className="users-section">
        <h2>Users List</h2>
        {users.length > 0 ? (
          <ul>
            {users.map((user) => (
              <li key={user.id}>
                {user.name} - {user.email}
              </li>
            ))}
          </ul>
        ) : (
          <p className="api-message">No users yet (DB not connected)</p>
        )}
      </div>
    </div>
  );
}

export default App;

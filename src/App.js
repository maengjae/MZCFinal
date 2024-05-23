import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Appbar from "./components/Appbar";
import Cosmetic from "./components/Cosmetics";
import CosmeticDetail from './components/CosmeticDetail';
import Register from './components/Register';
import Login from './components/Login';
import Logout from './components/Logout';

function App() {
  const [username, setUsername] = useState(null);

  useEffect(() => {
    // Check for a stored token and user info
    const token = localStorage.getItem('token');
    const storedUsername = localStorage.getItem('username');
    
    if (token && storedUsername) {
      setUsername(storedUsername);
    }
  }, []);

  return (
    <Router>
      <div className="App">
        <Appbar username={username} />
        <Routes>
          <Route path="/" element={<Cosmetic />} />
          <Route path="/cosmetic/:id" element={<CosmeticDetail />} />
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login setUsername={setUsername} />} />
          <Route path="/logout" element={<Logout setUsername={setUsername} />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;

import { useNavigate } from 'react-router-dom';
import { useEffect } from 'react';

export default function Logout({ setUsername }) {
  const navigate = useNavigate();

  useEffect(() => {
    localStorage.removeItem('token');
    localStorage.removeItem('username');
    setUsername(null);
    navigate('/');
  }, [navigate, setUsername]);

  return null;
}

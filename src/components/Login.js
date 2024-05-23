import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import { Link as RouterLink, useNavigate } from 'react-router-dom';

export default function Login({ setUsername }) {
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const username = formData.get('username');
    const password = formData.get('password');

    try {
      const response = await fetch(`${process.env.REACT_APP_domain}/api/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }), // Send username and password to the backend
      });

      if (response.ok) {
        const data = await response.json();
        console.log('Login successful', data);
        // Store the session token and username
        localStorage.setItem('token', data.token);
        localStorage.setItem('username', username);
        setUsername(username); // Update the state in the App component
        // Redirect the user to the dashboard or any other page
        navigate('/'); // Assuming you have a dashboard route
      } else {
        const errorData = await response.json();
        console.error('Login failed:', errorData.message);
        // Handle login failure (e.g., display error message to the user)
      }
    } catch (error) {
      console.error('Error logging in:', error);
      // Handle network errors or other exceptions
    }
  };

  return (
    <Box
      sx={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        height: '100vh',
      }}
    >
      <Typography variant="h4" gutterBottom>
        Login
      </Typography>
      <Box
        component="form"
        onSubmit={handleSubmit}
        sx={{
          width: '100%',
          maxWidth: 360,
          mt: 1,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <TextField
          id="username"
          name="username"
          label="Username"
          variant="outlined"
          margin="normal"
          required
          autoFocus
        />
        <TextField
          id="password"
          name="password"
          label="Password"
          type="password"
          variant="outlined"
          margin="normal"
          required
        />
        <Button type="submit" variant="contained" sx={{ mt: 3, mb: 2 }}>
          Login
        </Button>
        <Typography variant="body2">
          Don't have an account? <RouterLink to="/register">Register</RouterLink>
        </Typography>
      </Box>
    </Box>
  );
}

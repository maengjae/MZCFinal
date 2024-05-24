import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import { Link as RouterLink, useNavigate } from 'react-router-dom';

export default function Register() {
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const username = formData.get('username');
    const password = formData.get('password');
    const confirmPassword = formData.get('confirmPassword');
    console.log(JSON.stringify({ username, password }), // Send username and password to the backend
)
    if (password !== confirmPassword) {
        console.error('Passwords do not match');
        return;
    }

    try {
        const response = await fetch(`${process.env.REACT_APP_domain}/api/register`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ username, password }), // Send username and password to the backend
        });

        if (response.ok) {
            console.log('Registration successful');
            // Redirect the user to the login page
            navigate('/login');
          } else {
            const errorData = await response.json();
            console.error('Registration failed:', errorData.message);
            // Handle registration failure (e.g., display error message to the user)
          }
    } catch (error) {
          console.error('Error registering:', error);
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
        Register
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
          type="password"
          label="Password"
          variant="outlined"
          margin="normal"
          required
        />
        <TextField
          id="confirmPassword"
          name="confirmPassword"
          type="password"
          label="Confirm Password"
          variant="outlined"
          margin="normal"
          required
        />
        <Button type="submit" variant="contained" sx={{ mt: 3, mb: 2 }}>
          Register
        </Button>
        <Typography variant="body2">
          Already have an account? <RouterLink to="/login">Login</RouterLink>
        </Typography>
      </Box>
    </Box>
  );
}

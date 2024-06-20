import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import Button from '@mui/material/Button';
import { Link as RouterLink } from 'react-router-dom';

export default function Appbar({ username, handleLogout }) {
  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar>
          <IconButton
            size="large"
            edge="start"
            color="inherit"
            aria-label="menu"
            sx={{ mr: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            MJY online cosmetic shop merge test?
            helo~~~
          </Typography>
          {username ? (
            <>
              <Typography variant="h6" component="div" sx={{ flexGrow: 0, mr: 2 }}>
                {username}
              </Typography>
              <Button color="inherit" onClick={handleLogout}>
                Logout
              </Button>
            </>
          ) : (
            <>
              <Button
                component={RouterLink}
                to="/login"
                color="inherit"
              >
                Login
              </Button>
              <Button
                component={RouterLink}
                to="/register"
                color="inherit"
              >
                Register
              </Button>
            </>
          )}
        </Toolbar>
      </AppBar>
    </Box>
  );
}

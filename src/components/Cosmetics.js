import * as React from 'react';
import { Link } from 'react-router-dom';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Grid from '@mui/material/Grid';
import Container from '@mui/material/Container';

export default function Cosmetic() {
    const[name,setName]=React.useState('')
    const[address,setAddress]=React.useState('')
    const [imageURL, setImageURL] = React.useState(null);
    const[cosmetics,setCosmetics]=React.useState([])

    const handleClick=(e)=>{
      e.preventDefault()
      const cosmetic={name,address,imageURL}
      console.log(cosmetic)
      addCosmetic(cosmetic);
    };

    const addCosmetic = (cosmetic) => {
      fetch(`${process.env.REACT_APP_domain}/cosmetic/add`,{
    //   fetch(`https://${DOMAIN}/cosmetic/add`,{
          method: "POST",
          headers:{"Content-Type":"application/json"},
          body:JSON.stringify(cosmetic)
      })
      .then(()=>{
        console.log("New Cosmetic Added")
        fetchCosmetics();
      })
      .catch(error => {
        console.error('Error adding cosmetic:', error);
      });
    };

    const fetchCosmetics = () => {
      fetch(`${process.env.REACT_APP_domain}/cosmetic/getAll`)
    //   fetch(`https://${DOMAIN}/cosmetic/getAll`)
      .then(res=>res.json())
      .then((result)=>{
        setCosmetics(result);
      })
      .catch(error => {
        console.error('Error fetching cosmetics:', error);
      });
    };

    React.useEffect(()=>{
        fetchCosmetics();
    },[])

    return (
      <Container maxWidth="md">
          <Box
              component="form"
              sx={{
                  '& > :not(style)': { m: 1, width: '100%' },
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center'
              }}
              noValidate
              autoComplete="off"
              onSubmit={handleClick}
          >
              <Typography variant="h4" component="h1" color="primary" gutterBottom>
                  <u>Add Cosmetic</u>
              </Typography>
              <TextField
                  id="cosmetic-name"
                  label="Cosmetic Name"
                  variant="outlined"
                  fullWidth
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  required
              />
              <TextField
                  id="cosmetic-address"
                  label="Cosmetic Address"
                  variant="outlined"
                  fullWidth
                  value={address}
                  onChange={(e) => setAddress(e.target.value)}
              />
              <TextField
                  id="cosmetic-image-url"
                  label="Image URL"
                  variant="outlined"
                  fullWidth
                  value={imageURL}
                  onChange={(e) => setImageURL(e.target.value)}
              />
              <Button variant="contained" color="primary" type="submit">Submit</Button>
          </Box>

          <Typography variant="h4" component="h2" color="primary" gutterBottom sx={{ mt: 4 }}>
              Cosmetics
          </Typography>

          <Grid container spacing={4}>
              {cosmetics.map(cosmetic => (
                  <Grid item key={cosmetic.id} xs={12} sm={6} md={4}>
                      <Card>
                          {cosmetic.imageURL && (
                            <Link to={`/cosmetic/${cosmetic.id}`}>
                              <CardMedia
                                  component="img"
                                  height="200"
                                  image={cosmetic.imageURL}
                                  alt="Cosmetic"
                              />
                            </Link>
                          )}
                          <CardContent>
                              <Typography variant="h6" component="h3">
                                  Id: {cosmetic.id}
                              </Typography>
                              <Typography variant="body1">
                                  Name: {cosmetic.name}
                              </Typography>
                              <Typography variant="body1">
                                  Address: {cosmetic.address}
                              </Typography>
                          </CardContent>
                      </Card>
                  </Grid>
              ))}
          </Grid>
      </Container>
  );
}
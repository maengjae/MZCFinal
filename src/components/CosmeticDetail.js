import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { DOMAIN } from '../set';
import { Container, Typography, Box } from '@mui/material';

export default function CosmeticDetail() {
  const { id } = useParams();
  const [cosmetic, setCosmetic] = useState(null);

  useEffect(() => {
    fetch(`http://${process.env.REACT_APP_domain}/cosmetic/${id}`)
    // fetch(`https://${DOMAIN}/cosmetic/${id}`)
      .then(response => response.json())
      .then(data => setCosmetic(data))
      .catch(error => console.error('Error fetching cosmetic:', error));
  }, [id]);

  if (!cosmetic) {
    return <Typography>Loading...</Typography>;
  }

  return (
    <Container maxWidth="md">
      <Box sx={{ textAlign: 'center', mt: 4 }}>
        <Typography variant="h3" component="h1" color="primary" gutterBottom>
          {cosmetic.name}
        </Typography>
        <img src={cosmetic.imageURL} alt={cosmetic.name} style={{ maxWidth: '100%', height: 'auto' }} />
        <Typography variant="h5" component="h2" color="textSecondary" gutterBottom>
          Address: {cosmetic.address}
        </Typography>
        <Typography variant="body1">
          {/* Add any other detailed information here */}
        </Typography>
      </Box>
    </Container>
  );
}

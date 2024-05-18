import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import {DOMAIN} from '../set'

export default function Cosmetic() {
    const[name,setName]=React.useState('')
    const[address,setAddress]=React.useState('')
    const [imageURL, setImageURL] = React.useState(null);
    const[cosmetic,setCosmetic]=React.useState([])

    const handleClick=(e)=>{
      e.preventDefault()
      const cosmetic={name,address,imageURL}
      console.log(cosmetic)
      addcosmetic(cosmetic);
    };

    const addcosmetic = (cosmetic) => {
      // fetch(`http://${process.env.REACT_APP_domain}/cosmetic/add`,{
      fetch(`https://${DOMAIN}/cosmetic/add`,{
          method: "POST",
          headers:{"Content-Type":"application/json"},
          body:JSON.stringify(cosmetic)
      })
      .then(()=>{
        console.log("New cosmetic Added")
        fetchcosmetics();
      })
      .catch(error => {
        console.error('Error adding cosmetic:', error);
      });
    };

    const fetchcosmetics = () => {
      // fetch(`http://${process.env.REACT_APP_domain}/cosmetic/getAll`)
      fetch(`https://${DOMAIN}/cosmetic/getAll`)
      .then(res=>res.json())
      .then((result)=>{
        setcosmetics(result);
      })
      .catch(error => {
        console.error('Error fetching cosmetics:', error);
      });
    };

    React.useEffect(()=>{
        fetchcosmetics();
    },[])

  return (
    <Box
      component="form"
      sx={{
        '& > :not(style)': { m: 1, width: '25ch' },
      }}
      noValidate
      autoComplete="off"
    >
      <h1 style={{color:"blue"}}><u>Add cosmetic</u></h1>
      <TextField 
      id="standard-basic" 
      label="cosmetic Name" 
      variant="standard" 
      fullWidth 
      value={name}
      onChange={(e)=>setName(e.target.value)}
      required
      />
      <TextField 
      id="standard-basic" 
      label="cosmetic Address" 
      variant="standard" 
      fullWidth 
      value={address}
      onChange={(e)=>setAddress(e.target.value)}
      />
      <TextField 
      id="standard-basic" 
      label="Image URL" 
      variant="standard" 
      fullWidth 
      value={imageURL}
      onChange={(e)=>setImageURL(e.target.value)}
      />
      <Button variant="contained" onClick={handleClick}>Submit</Button>
      
      <h1> cosmetics</h1>

      {cosmetics.map(cosmetic=>(
        <h5 key={cosmetic.id}>
        Id:{cosmetic.id}<br/>
        Name:{cosmetic.name}<br/>
        Address:{cosmetic.address}<br/>
        {cosmetic.imageURL && <img src={cosmetic.imageURL} alt="cosmetic" style={{ maxWidth: '200px', maxHeight: '200px' }} />}
        </h5>
      ))}
    </Box>
  );
}

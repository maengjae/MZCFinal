import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import { DOMAIN } from '../set';

export default function Student() {
    const[name,setName]=React.useState('')
    const[address,setAddress]=React.useState('')
    const[students,setStudents]=React.useState([])

    const handleClick=(e)=>{
        e.preventDefault()
        const student={name,address}
        console.log(student)
        // fetch(`http://${process.env.REACT_APP_DOMAIN}/student/add`,{
        fetch(`http://${DOMAIN}/student/add`,{
            method: "POST",
            headers:{"Content-Type":"application/json"},
            body:JSON.stringify(student)
        }).then(()=>{
            console.log("New Student Added")
            fetchStudents();
        })
    }

    const fetchStudents = () => {
      // fetch(`http://${process.env.REACT_APP_DOMAIN}/student/getAll`)
      fetch(`http://${DOMAIN}/student/getAll`)
      .then(res=>res.json())
      .then((result)=>{
        setStudents(result);
      })
      .catch(error => {
        console.error('Error fetching students:', error);
      });
    }

    React.useEffect(()=>{
        fetchStudents();
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
      <h1 style={{color:"blue"}}><u>Add Student</u></h1>
      <TextField id="standard-basic" label="Student Name" variant="standard" fullWidth 
      value={name}
      onChange={(e)=>setName(e.target.value)}
      />
      <TextField id="standard-basic" label="Student Address" variant="standard" fullWidth 
      value={address}
      onChange={(e)=>setAddress(e.target.value)}
      />
      <Button variant="contained" onClick={handleClick}>Submit</Button>
      
      <h1> Students</h1>

      {students.map(student=>(
        <h5 key={student.id}>
        Id:{student.id}<br/>
        Name:{student.name}<br/>
        Address:{student.address}
        </h5>
      ))}
    </Box>
  );
}

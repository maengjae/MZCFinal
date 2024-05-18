import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';

export default function Student() {
    const[name,setName]=React.useState('')
    const[address,setAddress]=React.useState('')
    const [imageURL, setImageURL] = React.useState(null);
    const[students,setStudents]=React.useState([])

    const handleClick=(e)=>{
      e.preventDefault()
      const student={name,address,imageURL}
      console.log(student)
      addStudent(student);
    };

    const addStudent = (student) => {
      fetch(`http://${process.env.REACT_APP_domain}/student/add`,{
      // fetch(`https://${DOMAIN}/student/add`,{
          method: "POST",
          headers:{"Content-Type":"application/json"},
          body:JSON.stringify(student)
      })
      .then(()=>{
        console.log("New Student Added")
        fetchStudents();
      })
      .catch(error => {
        console.error('Error adding student:', error);
      });
    };

    const fetchStudents = () => {
      fetch(`http://${process.env.REACT_APP_domain}/student/getAll`)
      // fetch(`https://${DOMAIN}/student/getAll`)
      .then(res=>res.json())
      .then((result)=>{
        setStudents(result);
      })
      .catch(error => {
        console.error('Error fetching students:', error);
      });
    };

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
      <TextField 
      id="standard-basic" 
      label="Student Name" 
      variant="standard" 
      fullWidth 
      value={name}
      onChange={(e)=>setName(e.target.value)}
      required
      />
      <TextField 
      id="standard-basic" 
      label="Student Address" 
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
      
      <h1> Students</h1>

      {students.map(student=>(
        <h5 key={student.id}>
        Id:{student.id}<br/>
        Name:{student.name}<br/>
        Address:{student.address}<br/>
        {student.imageURL && <img src={student.imageURL} alt="Student" style={{ maxWidth: '200px', maxHeight: '200px' }} />}
        </h5>
      ))}
    </Box>
  );
}

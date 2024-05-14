import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import { config} from '../set';
import S3FileUpload from 'react-s3/lib/ReactS3';

export default function Student() {
    const[name,setName]=React.useState('')
    const[address,setAddress]=React.useState('')
    const [imageFile, setImageFile] = React.useState(null);
    const[students,setStudents]=React.useState([])

    const handleClick=(e)=>{
      e.preventDefault()
      const student={name,address,image}
      console.log(student)

      if(imageFile) {
        S3FileUpload.uploadFile(imageFile, config)
        .then((data) => {
          console.log("Image uploaded:", data.location);
          student.imageURL = data.location;
          addStudent(student);
        })
        .catch((err) => {
          console.error('Error uploading image:', err);
        });
      } else {
        addStudent(student);
      }
    };

    const addStudent = (student) => {
      fetch(`http://${process.env.App_domain}/student/add`,{
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
      fetch(`http://${process.env.REACT_App_domain}/student/getAll`)
      // fetch(`https://${DOMAIN}/student/getAll`)
      .then(res=>res.json())
      .then((result)=>{
        setStudents(result);
      })
      .catch(error => {
        console.error('Error fetching students:', error);
      });
    };

    const handleFileChange = (e) => {
      setImageFile(e.target.files[0]);
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
      <input type='file' onChange={handleFileChange} />
      <Button variant="contained" onClick={handleClick}>Submit</Button>
      
      <h1> Students</h1>

      {students.map(student=>(
        <h5 key={student.id}>
        Id:{student.id}<br/>
        Name:{student.name}<br/>
        Address:{student.address}<br/>
        {student.imageURL && <img src={student.image} alt="Student"/>}
        </h5>
      ))}
    </Box>
  );
}

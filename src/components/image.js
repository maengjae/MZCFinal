import { Box } from '@mui/material';
import React, { Component } from 'react';
import S3FileUpload from 'react-s3';
 
const config = {
    bucketName: 'mjy-static-deploy',
    dirName: 'photos', /* optional */
    region: 'us-east-2',
    accessKeyId: process.env.Access_key_ID,
    secretAccessKey: process.env.Secret_access_key,
}

class Image extends Component {
    constructor(){
        super();
    }
    upload(e){
        console.log(e.target.files[0]);
        S3FileUpload.upload(e.target.files[0],config)
        .then((data)=>{
            console.log(data.location);
        })
        .catch((err)=>{
            alert(err);
        })
    }
    render(){
        return (
            <Box>
                <h3>
                    aws s3 upload
                </h3>
                <input type="file" onChange={this.upload}/> 
            </Box>
        )
    }
}

export default Image
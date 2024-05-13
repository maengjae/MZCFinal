import { Box } from '@mui/material';
import React, { useState } from 'react';
import S3FileUpload from 'react-s3';
 
const config = {
    bucketName: 'mjy-static-deploy',
    dirName: 'photos', /* optional */
    region: 'us-east-2',
    accessKeyId: process.env.Access_key_ID,
    secretAccessKey: process.env.Secret_access_key,
}

export default function Image() {
    const [selectedFile, setSelectedFile] = useState(null);

    const upload = () => {
        if (selectedFile) {
            S3FileUpload.upload(selectedFile, config)
                .then((data) => {
                    console.log(data.location);
                })
                .catch((err) => {
                    alert(err);
                });
        } else {
            alert('Please select a file first.');
        }
    };

    const handleFileChange = (e) => {
        setSelectedFile(e.target.files[0]);
    };

    return (
        <Box>
            <h3>aws s3 upload</h3>
            <input type="file" style={{ display: 'fileimage' }} onChange={handleFileChange} ref={(fileInput) => (this.fileInput = fileInput)} />
            <button onClick={() => this.fileInput.click()}>Select File</button>
            <button onClick={upload}>Upload</button>
        </Box>
    );
}
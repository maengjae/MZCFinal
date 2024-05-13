import React, { useState } from 'react';
import S3FileUpload from 'react-s3';

const config = {
    bucketName: 'mjy-static-deploy',
    dirName: 'photos', /* optional */
    region: 'us-east-2',
    accessKeyId: process.env.Access_key_ID,
    secretAccessKey: process.env.Secret_access_key,
}

const ImageUploader = () => {
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
        <div>
            <h3>Upload Image to S3</h3>
            <input type="file" onChange={handleFileChange} />
            <button onClick={upload}>Upload</button>
        </div>
    );
}

export default ImageUploader;

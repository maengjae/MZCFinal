import React, { useState } from 'react';
import S3FileUpload from 'react-s3';
import { config } from '../set';
window.Buffer = window.Buffer || require("buffer").Buffer;


export default function Image() {
    const [selectedFile, setSelectedFile] = useState(null);

    const upload = () => {
        if (selectedFile) {
            S3FileUpload.uploadFile(selectedFile, config)
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
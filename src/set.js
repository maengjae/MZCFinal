export const config = {
    bucketName: 'mjy-static-deploy',
    dirName: 'images', /* optional */
    region: 'us-east-2',
    accessKeyId: process.env.REACT_APP_ID,
    secretAccessKey: process.env.REACT_APP_SECRET,
    s3Url: 'http://mjy-static-deploy.s3.us-east-2.amazon.com/'
}
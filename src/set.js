export const DOMAIN = "back.jaejae.store" 
// export const DOMAIN = "localhost:34000"


export const config = {
    bucketName: 'mjy-static-deploy',
    dirName: 'images', /* optional */
    region: 'us-east-2',
    accessKeyId: process.env.Access_key_ID,
    secretAccessKey: process.env.Secret_access_key,
}
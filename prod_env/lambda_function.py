from __future__ import print_function
import boto3
import time
import os

def lambda_handler(event, context):
    path = []
    for items in event["Records"]:
        path.append("/" + items["s3"]["object"]["key"])
    print(path)
    client = boto3.client('cloudfront')
    invalidation = client.create_invalidation(
        DistributionId=os.environ['CLOUDFRONT_DISTRIBUTION_ID'],
        InvalidationBatch={
            'Paths': {
                'Quantity': len(path),
                'Items': path
            },
            'CallerReference': str(time.time())
        }
    )
    print(f"Invalidation created: {invalidation}")

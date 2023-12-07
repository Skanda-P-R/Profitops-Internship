import boto3

def get_file_extension(file_key):
    # Extract and return the file extension
    return file_key.split('.')[-1].lower()

def lambda_handler(event, context):
    source_bucket = 'awsbkt870'  
    destination_bucket = 'versions870'  

    s3 = boto3.client('s3')

    # List all objects in the source bucket
    objects = s3.list_objects(Bucket=source_bucket)

    # Iterate through each object and its versions, and copy to the destination bucket
    for obj in objects.get('Contents', []):
        key = obj['Key']

        # List all versions of the current object in the source bucket
        versions = s3.list_object_versions(Bucket=source_bucket, Prefix=key)['Versions']
        
        # Reverse the order of versions
        versions.reverse()

        # Iterate through each version and copy it to the destination bucket
        for index, version in enumerate(versions, start=1):
            version_id = version['VersionId']
            file_extension = get_file_extension(key)
            
            # Determine the folder based on the file extension
            if file_extension == 'csv':
                folder = 'CSV_FILES'
            elif file_extension == 'xml':
                folder = 'XML_FILES'
            elif file_extension == 'json':
                folder = 'JSON_FILES'
            else:
                # Handle other file types as needed
                folder = 'OTHER_FILES'

            new_key = f"{folder}/{index}_{key.split('/')[-1]}"

            # Check if the file with the new key already exists in the destination bucket
            try:
                s3.head_object(Bucket=destination_bucket, Key=new_key)
                print(f"Version {index} of {key} already exists in {destination_bucket}/{new_key}")
            except s3.exceptions.ClientError as e:
                if e.response['Error']['Code'] == '404':
                    # File not found, proceed with copying
                    try:
                        s3.copy_object(
                            Bucket=destination_bucket,
                            CopySource={'Bucket': source_bucket, 'Key': key, 'VersionId': version_id},
                            Key=new_key
                        )
                        print(f"Version {index} of {key} copied to {destination_bucket}/{new_key}")
                    except s3.exceptions.ClientError as e:
                        print(f"Error copying {new_key}: {e}")
                else:
                    print(f"Error checking {new_key}: {e}")
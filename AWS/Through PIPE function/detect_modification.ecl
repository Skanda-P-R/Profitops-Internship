IMPORT PYTHON3 AS PYTHON;

STRING directory_in_lz:='';//directory in the landing zone synced in the bucket
STRING prefix := 'CSV_FILES/';//FOLDER IN THE BUCKET
STRING bucket_name :='versions870';
// Replace these values with your AWS credentials and default region
STRING aws_access_key_id := '';
STRING aws_secret_access_key := '';
STRING aws_default_region := '';
STRING sprayed_name := '';//target scope


INTEGER detect(STRING aws_access_key_id, STRING aws_secret_access_key, STRING aws_default_region, STRING directory_in_lz, STRING prefix, STRING bucket_name, STRING sprayed_name) := EMBED(PYTHON)
import subprocess
import boto3
import os

# Run the aws configure commands with input
configure_commands = [
    ["aws", "configure", "set", "aws_access_key_id", aws_access_key_id],
    ["aws", "configure", "set", "aws_secret_access_key", aws_secret_access_key],
    ["aws", "configure", "set", "region", aws_default_region]
]

# Execute each configure command
for command in configure_commands:
    subprocess.run(command, check=True)

print("AWS CLI has been configured in the terminal.")
dir='/var/lib/HPCCSystems/mydropzone/' + directory_in_lz
# List files in the local directory
synced_dir = os.listdir(dir)  #list of items onlanding zone

# Print the list of local files
print("List of files in the landing zone:")
print(synced_dir)

directory_path = "/var/lib/HPCCSystems/mydropzone/"+directory_in_lz

dfuplus_command = (
    "dfuplus action=spray server=http://localhost:8010/ "
    f"srcip=10.0.2.15 format=csv dstname={sprayed_name} prefix=FILENAME dstcluster=mythor overwrite=1 srcfile=/var/lib/HPCCSystems/mydropzone/CSV/*.csv"
)

dfu_command_in_del = (
    "dfuplus action=spray server=http://localhost:8010/ "
    f"srcip=10.0.2.15 format=csv dstname={sprayed_name} prefix=FILENAME dstcluster=mythor overwrite=1 "
)
subprocess.run(["cd", directory_path], shell=True, check=True)
# Run the dfuplus command
subprocess.run(dfuplus_command, shell=True, check=True)
def list_objects_in_bucket(bucket_name, folder_name):
# Create an S3 client
    s3 = boto3.client('s3', aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key, region_name=aws_default_region)
    response = s3.list_objects_v2(Bucket=bucket_name, Prefix = prefix)
    return [obj['Key'][len(folder_name):] for obj in response.get('Contents', [])][1:]

# spray the files
subprocess.run(["cd", directory_path], shell=True, check=True)
print(set(synced_dir))
print()
print(set(list_objects_in_bucket(bucket_name, prefix)))
import time
while True:
    time.sleep(7)
    if (set(synced_dir) == set(list_objects_in_bucket(bucket_name, prefix))):

        continue
    else:
        if (len(set(synced_dir) - set(list_objects_in_bucket(bucket_name, prefix))) > 0):
            l1 = (list(set(list_objects_in_bucket(bucket_name, prefix))))
            if l1 == []:
                print("DIRECTORY IS EMPTY")
                continue
            print('files in dir are more than files on the bucket') 
            l1 = [dir + '/'+ x + ',' for x in l1]
            l1[0]='srcfile='+l1[0]
            l1[len(l1)-1] = l1[len(l1)-1][0:-1]
            l1 = "".join(l1)
            print(l1)
            time.sleep(60) #directory is now synced with the bucket
            #WE HAVE TO RE-SYNC THE DIRECTORY AT THIS POINT -> 60 SECONDS WAITING PERIOD
            subprocess.run(dfu_command_in_del + l1, shell=True, check=True)
        
            synced_dir = os.listdir(dir)
            continue
        
        subprocess.run(["cd", directory_path], shell=True, check=True)
        time.sleep(60)
        # Run the dfuplus command
        subprocess.run(dfuplus_command, shell=True, check=True)
        synced_dir = os.listdir(dir)
       
return 2
ENDEMBED;

detect(aws_access_key_id,  aws_secret_access_key, aws_default_region,  directory_in_lz,  prefix,  bucket_name,  sprayed_name);

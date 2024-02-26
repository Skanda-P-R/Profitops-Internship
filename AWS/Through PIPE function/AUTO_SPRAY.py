directory_in_lz='CSV/NEW'#directory in the landing zone synced in the bucket
prefix = 'new/'#FOLDER IN THE BUCKET
bucket_name='awsbkt870'
# Replace these values with your AWS credentials and default region
aws_access_key_id = ""
aws_secret_access_key = ""
aws_default_region = ""
sprayed_name = "hthor::example::files_sprayed"

import subprocess
import boto3
import os
#NAMES ARE COMPARED SO AND NOT A COUNT IN CASES WHERE FILES ARE ADDED AND REMOVED SIMULTANEOUSLY 
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
    f"srcip=10.0.2.15 format=csv dstname={sprayed_name} prefix=FILENAME dstcluster=mythor overwrite=1 srcfile=/var/lib/HPCCSystems/mydropzone/CSV/NEW/*.csv"
)



subprocess.run(["cd", directory_path], shell=True, check=True)


def list_objects_in_bucket(bucket_name, folder_prefix):
    s3 = boto3.client('s3')

    # List objects in the bucket with the specified prefix
    response = s3.list_objects_v2(Bucket=bucket_name, Prefix=folder_prefix)

    # Extract file names (stripped of folder prefix) from the response
    file_list = []
    for obj in response.get('Contents', []):
        # Strip folder prefix from file name
        file_name = obj['Key'].replace(folder_prefix, '', 1)
        file_list.append(file_name)

    return file_list

# spray the files
dir='/var/lib/HPCCSystems/mydropzone/' + directory_in_lz 
synced_dir = os.listdir(dir)
subprocess.run(dfuplus_command, shell=True, check=True)
subprocess.run(["cd", directory_path], shell=True, check=True)

def removeFirstCharacter(l):
    return [s[0:] for s in l]

print(set(synced_dir))
print()
print(removeFirstCharacter(set(list_objects_in_bucket(bucket_name, prefix))))


import time
while True:
    time.sleep(7)
    if (set(synced_dir) == set(removeFirstCharacter(list_objects_in_bucket(bucket_name, prefix)))):
        print('NO DIFFERENCE')
        continue
    else:
        if (len(set(synced_dir) - set(removeFirstCharacter(list_objects_in_bucket(bucket_name, prefix)))) > 0):
            print("THE DIFFERENCE IS: ", len(set(synced_dir) - set(list_objects_in_bucket(bucket_name, prefix))))
            print(set(removeFirstCharacter(list_objects_in_bucket(bucket_name, prefix))))
            l1 = (list(set(list_objects_in_bucket(bucket_name, prefix))))
            if l1 == []:
                print("DIRECTORY IS EMPTY")
                continue
            print('files in dir are more than files on the bucket') 
            print("COUNT IN L1", len(l1))
            print("file in l1",l1[0])

            
            #WE HAVE TO RE-SYNC THE DIRECTORY AT THIS POINT -> 60 SECONDS WAITING PERIOD
            subprocess.run(dfuplus_command, shell=True, check=True)
            time.sleep(60) #directory is now synced with the bucket
            synced_dir = os.listdir(dir)
            continue
        
        subprocess.run(["cd", directory_path], shell=True, check=True)
        
        # Run the dfuplus command
        subprocess.run(dfuplus_command, shell=True, check=True)
        synced_dir = os.listdir(dir)
        time.sleep(60) #directory is now synced with the bucket

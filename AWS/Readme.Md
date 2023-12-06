 <h1>HPCC CONNECTIVITY WITH AWS S3</h1>
1.	Note: Store the following files on the same directory: configuration_on_term.sh, sync.sh, spray.sh and despray.sh. We can run the specified commands in this directory. Also once these files are in the directory, run the command:
     chmod +x <script_file_name_1>   <script_file_name_2>  …. 
You can pass all these files in the same line as command line arguments. You are giving the script file execute permission by doing this.
2.	AWS S3 configuration with the HPCC Cluster:
•	Upload the file credentials.sh, a script file that consists of details required to configure s3cmd and aws cli.
•	The file is now is at: var/lib/HPCCSystems/mydropzone and can be accessed from that location. The file consists of the following details:
ACCESS_KEY=""
SECRET_KEY=""
DEFAULT_REGION=""
S3_ENDPOINT=""
BUCKET_TEMPLATE=""
ENCRYPTION_PASSWORD=""
GPG_PROGRAM=""
USE_HTTPS="" #yes/no
HTTP_PROXY_NAME=""
TEST_CASE="" #y/n
SAVE_SETTINGS="" #y/n
RETRY_CONFIGURATION=""  #y/n
•	Now, store the file configuration_on_term.sh, a file that consist of the script to configure s3cmd and aws cli in a directory. 
•	Run the following command:
./configuration_on_term.sh
•	S3cmd and aws cli are now configured with your landing zone.
3.	Now, let us sync the AWS bucket with the HPCC Cluster using aws cli. Create a script file, sync.sh and store it in the same common directory. Let us now put this file on the crontab. For that:
            crontab -e
The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:
* * * * * /path/to/sync.sh
Now the landing zone directory has been synced with AWS S3 with a delay of 1 minute.  
So 

4.	Spraying files from Landing Zone to Logical Files: Since the bucket is synced with the Landing Zone, our task now is to spray a given file from the landing zone to logical files. For that we have the bash script named auto_spray.sh which sprays the files that are in landing zone initially for the first time and then looks for added files in the in our bucket. If a new file is added in the bucket, then it is automatically sprayed to the thor cluster and also immediately removed from the landing zone because it is no longer needed after being sprayed. Now we need to put this in crontab to regularly monitor the added files . For that:
            crontab -e
The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:
* * * * * /path/to/auto_spray.sh


5.	Versioning: To handle with the versions, we have approached so that we have two buckets here 1) awsbkt870(this contains the latest original versions of all the files) and 2) versions870(this contains all the version of each file in awsbkt870)
In sync.sh we have synced the versions870 bucket with landing zone so that 
a.	If the user wants to use only a specific version, he can spray the required version to thor cluster using spray.sh file. So, this basically takes command line argument of which filename you want to spray that particular file.
Run the following command.
  ./spray.sh <version_name_with_extension>  
b.	Or if the user wants all the files to get sprayed then he can do that using 



6.	Despraying files: This involves the despraying of the file from thor cluster whenever a file in deleted in s3bucket after its completion of usage. For this there is a bash script called despray.sh. This files is put in crontab to regularly monitor the bucket and despray the files that are deleted in the bucket. For that:
            crontab -e
The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:
* * * * * /path/to/despray.sh

7.	Incremental push we have done so far: What we have done so far is directly worked on the ‘diff’ file and combined it with the original file. For that, we run the code below on ECL IDE. Our next task is to enable versioning on AWS S3 and then perform incremental data push. This is the example with csv files:






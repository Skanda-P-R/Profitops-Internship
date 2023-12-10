 <h1>HPCC CONNECTIVITY WITH AWS S3</h1>
<h2>1.	Note</h2>  Store the following files on the same directory: configuration_on_term.sh, sync.sh, spray.sh and despray.sh. We can run the specified commands in this directory. Also once these files are in the directory, run the command:

```
chmod +x <script_file_name_1>  <script_file_name_2> ....
```
You can pass all these files in the same line as command line arguments. You are giving the script file execute permission by doing this.
     
<h2>2.	AWS S3 configuration with the HPCC Cluster</h2>
•	Upload the file credentials.sh, a script file that consists of details required to configure s3cmd and aws cli.
•	The file is now is at: var/lib/HPCCSystems/mydropzone and can be accessed from that location. 
•	Now, store the file configuration_on_term.sh, a file that consist of the script to configure s3cmd and aws cli in a directory. 
•	Run the following command:

```
./configuration_on_term.sh
```
•	S3cmd and aws cli are now configured with your landing zone.

<h2>3. Real time synchronization</h2>	Now, let us sync the AWS bucket with the HPCC Cluster using aws cli. Create a script file, sync.sh and store it in the same common directory. Let us now put this file on the crontab. For that:

```
crontab -e
```

The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:

 ```     
 * * * * * /path/to/sync.sh
 ```
     
Now the landing zone directory has been synced with AWS S3 with a delay of 1 minute.  


<h2>4.	Spraying files from Landing Zone to Logical Files</h2> Since the bucket is synced with the Landing Zone, our task now is to spray a given file from the landing zone to logical files. For that we have the bash script named auto_spray.sh which sprays the files that are in landing zone initially for the first time and then looks for added files in the in our bucket. If a new file is added in the bucket, then it is automatically sprayed to the thor cluster and also immediately removed from the landing zone because it is no longer needed after being sprayed. Now we need to put this in crontab to regularly monitor the added files . For that:

```
crontab -e
```

The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:
```
* * * * * /path/to/auto_spray.sh
```


<h2>5.	Versioning</h2> To handle with the versions, we have approached so that we have two buckets here 1) awsbkt870(this contains the latest original versions of all the files) and 2) versions870(this contains all the version of each file in awsbkt870)
In sync.sh we have synced the versions870 bucket with landing zone so that 
a.	If the user wants to use only a specific version, he can spray the required version to thor cluster using spray.sh file. So, this basically takes command line argument of which filename you want to spray that particular file.
Run the following command.

```
./spray.sh <version_name_with_extension>
```

b.	Or if the user wants all the files to get sprayed then he can do that using 

<h2>6.	Despraying files</h2> This involves the despraying of the file from thor cluster whenever a file in deleted in s3bucket after its completion of usage. For this there is a bash script called despray.sh. This files is put in crontab to regularly monitor the bucket and despray the files that are deleted in the bucket. For that:

```
crontab -e
```

The crontab has now opened. Give the following command to sync the bucket every minute with the Landing Zone:

```
* * * * * /path/to/despray.sh
```

<h2>7.	Incremental push</h2> The task of incremental datapush has definitions specific to various use cases. In this case, the use of incremental data push is to extract the modifications that occur between two versions of a file on the AWS bucket. This involved bringing the file(CSV, JSON or XML) from the bucket along with its new version and extracting these modifications. The file <b>incremental_push_<file_format>.ecl</b> demonstrates incremental push on a simple CSV file using ECL join functions.






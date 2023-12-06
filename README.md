# Integrating MySQL in ECL

**Step 1**: Install HPCC Cluster (Ignore if already installed)
In my case, I have downloaded the VM file to run the HPCC Cluster. The last version of HPCC cluster available is v8.2.0-1. You can download it from here: https://d2wulyp08c6njk.cloudfront.net/releases/CE-Candidate-8.2.0/bin/vm/HPCCSystemsVM-amd64-8.2.0-1.ova
Also download and install Oracle VM Virtual Box.
Open Virtual Box and click on File, and then Import Appliance, then select the path where you have downloaded the HPCCSystemsVM-amd64-8.2.0-1.ova file, then click Next and Finish.
Then select the installed VM and click on settings. Go to Network Tab. In Adapter 1, select Attached to “NAT” and for Adapter 2, select Attached to “Host-only Adapter”. Click OK and double click to start the VM.
 
**Step 2**: Install MySQL Server
For installing MySQL server, follow the steps in this video: https://youtu.be/zRfI79BHf3k?si=4hVRc4XKiT4dV8p5
 
**Step 3**: Open ECL Watch and upload the csv data
From the login page, copy the URL for ECL Watch and open it in a browser
 
In ECL watch navigate to Logical Files, Landing Zone. Here open Mydropzone and select upload.
   
After selecting upload, select the csv file to upload and click Finish. You will see the file name after uploading.

**Step 4**: Create Database and Table in MySQL
Open the VM and type following code
sudo mysql -u root -p
Then give the root password which you set while installing MySQL. 
You would have successfully connected to mysql server.
Then type this code
CREATE DATABASE test_db;
USE test_db;
CREATE TABLE test_tb(
id int,
cid float,
pic50 float);
In test_tb table, we have to create it based on the content in the csv file. I am using a csv file which has three attributes id, cid and pic50. 
Then you can either type “exit;” or keep it running in the background.

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


### MySqlImport.ecl
This code outputs a single string as a result which contains a module that can be used to access all the tables in the MySql database. 
<br>When we create a database called test_db in MySQL server using the command:
<br>```CREATE DATABASE test_db;```
<br>Then if we create a table using the command:<br>
```
CREATE TABLE test(
        id int,
        cid float,
        pic50 float);
```
<br>Now if we run this ecl file, we will get the following output<br>
```
IMPORT MySql;
EXPORT test_dbDatabase(string user, string password) := MODULE
    EXPORT testRecord := RECORD
        INTEGER4 id;
        REAL4 cid;
        REAL4 pic50;
    END;
END;
```
This functionality is used to create multiple functions in the next file.

### test_dbDatabase.ecl
This file contains different DML and DDL functions wrapped into a single module, so that the functions can be called directly in other file.<br>
<br>It consistes of:
* Creating new tables in MySQL server.
* Inserting contents from CSV and XML files, which are stored in the HPCC Cluster, to MySQL table.
* Storing the contents of MySQL table to a Logical file in HPCC Cluster.
* Deleting content from MySQL table.
* Deleting the MySQL table.

### Function_Call.ecl
As the name of the file indicates, this file is used just to call the functions which were created in test_dbDatabase.ecl.

### Incremental_Push_Function_Definition.ecl
Consider files order v1.csv and order v2.csv which has the content as follows:<br><br>**_order v1.csv_**
| Order ID | Order Name           | Name    | Price  |
|----------|----------------------|---------|--------|
| 1        | iPhone 13            | Arun    | 75000  |
| 2        | iPhone 14 Pro Max    | Skanda  | 85000  |
| 3        | Samsung Earpods      | Shiv    | 5000   |
| 4        | MacBook Pro          | Aneesh  | 90000  |
| 5        | Samsung Z Fold       | Suhas   | 95000  |
| 6        | iPhone 13 Mini       | Dheeraj | 70000  |
| 7        | iPhone 15 Pro Max    | Nikhil  | 100000 |
| 8        | iPhone 15            | Syed    | 98000  |
| 9        | Samsung Z Flip       | Vaibhav | 98000  |
| 10       | Samsung S23 Ultra    | Tejas   | 80000  |

**_order v2.csv_**

| Order ID | Order Name           | Name       | Price |
|----------|----------------------|------------|-------|
| 1        | iPhone 12            | Arun       | 50000 |
| 11       | iPhone 12            | Shrivarsha | 50000 |
| 12       | Samsung S23          | Shrinidi   | 80000 |
| 13       | Samsung Earpods      | Skanda     | 5000  |
| 2        | iPhone 14 Pro        | Skanda     | 75000 |
| 14       | Samsung Earpods      | Arun       | 5002  |
| 5        | iPhone 15            | Suhas      | 98000 |

When these two files are merged, we should get an output like this:<br>
| Order ID | Order Name           | Name       | Price |
|----------|----------------------|------------|-------|
| 1        | iPhone 12            | Arun       | 50000 |
| 2        | iPhone 14 Pro        | Skanda     | 75000 |
| 3        | Samsung Earpods      | Shiv       | 5000  |
| 4        | MacBook Pro          | Aneesh     | 90000 |
| 5        | iPhone 15            | Suhas      | 98000 |
| 6        | iPhone 13 Mini       | Dheeraj    | 70000 |
| 7        | iPhone 15 Pro Max    | Nikhil     | 100000|
| 8        | iPhone 15            | Syed       | 98000 |
| 9        | Samsung Z Flip       | Vaibhav    | 98000 |
| 10       | Samsung S23 Ultra    | Tejas      | 80000 |
| 11       | iPhone 12            | Shrivarsha | 50000 |
| 12       | Samsung S23          | Shrinidi   | 80000 |
| 13       | Samsung Earpods      | Skanda     | 5000  |
| 14       | Samsung Earpods      | Arun       | 5002  |

This is just an example, we can change the values in order version 2 CSV and still, the original table gets modified and gets stored in HPCC Cluster with logical name **spr::order_modified**. This is done using the functions defined in **Incremental_Push_Function_Definition.ecl** and these functions are called in **Incremental_Push_Function_Call.ecl**.<br>
In addition to this, we also get the outputs
| Order ID | Order Name           | Name       | Price |
|----------|----------------------|------------|-------|
| 11       | iPhone 12            | Shrivarsha | 50000 |
| 12       | Samsung S23          | Shrinidi   | 80000 |
| 13       | Samsung Earpods      | Skanda     | 5000  |
| 14       | Samsung Earpods      | Arun       | 5002  |

which specifies what new contents are added to the table and
| Order ID | Order Name     | Name   | Price |
|----------|----------------|--------|-------|
| 1        | iPhone 12      | Arun   | 50000 |
| 2        | iPhone 14 Pro  | Skanda | 75000 |
| 5        | iPhone 15      | Suhas  | 98000 |

which specifies the content which is modified in the table, so that the user can get to know what changes are there in both the order versions. All these are carried out by calling the get(), get_added() and get_modified() functions which are present in Incremental_Push_Function_Definition.ecl file.<br>
<br>

<h1><b>AWS S3 CONNECTIVITY USING PIPE FUNCTION</b></h1>

1. PIPE function in ECL enables us to run terminal commands on the lanidding zone of the cluster. However, this function requires to be enabled to work with through ECL IDE. Using the pipe function, one can configure his AWS S3 credentials to AWS CLI, a useful command line tool for performing tasks related to AWS S3. A sample example can be shown below:
```
rec := RECORD
    STRING message;
END;
PIPE('aws configure set aws_access_key_id __youraccesskey__', rec, csv);
```
2. In this approach, we have also found a way to spray a very large number of files (given they are of the same format) at once in lesser time. We have sprayed all these files as a single file. So, we make use of the dfuplus command line tool for performing this, which provides an option of adding a prefix. When the prefix is kept as FILENAME, all the files can be seen seperated in that single file, with their names appearing at the first column along with the field of the first column. The user can input the file name and extract all the file contents of the entered name. The idea here is to extract the indices between which the contents of the file lies and then making use of it. For this, we have made use of python embedding to extract those files.

4. However the file names in the single sprayed file do not appear normally but as a matching string that follows a matching string of a regular expression. So the task involves seperating the file name from this string and then also seperating it from the first column it appears it to extract them further. So we made use of the REGEXFIND() function in ECL which seperates the file name from the appearing expression. This approach takes place in <b>file_extraction.ecl</b>.

5. So therefore, this approach involves syncing the bucket containing all the version objects of the main bucket and syncing it to the landing zone. This is done using PIPE() function. Once the syncing is done, we spray files of a single format into a single target scope, in simple terms, a single file. The user then just has to input the file name (here, in file_extraction.ecl, file number assuming the files follow a natural order) he wants to extract from the landing zone and can define a record structure for it to use it on the ECL IDE.
   
6. The task involves monitoring and keeping a constant check on any changes in the synced bucket. In case files of a specific format are removed/added to the bucket within a time frame, then the files of the format/folder are resprayed again due to these detections, since we sprayed a single file before and cannot remove the contents of an already sprayed file.
   
7. The advantage of this approach is that is that it just requires PIPE authorization and AWS CLI installation on the cluster and not complete control over the cluster.Configuration, syncing and spraying take place through 2 ECL files: <b>config_and_sync.ecl</b> and <b>detect_modification.ecl</b>. The detect_modification.ecl file involves python embedding and the use of subprocess module to spray automatically in case of any modifications in the versions bucket. 

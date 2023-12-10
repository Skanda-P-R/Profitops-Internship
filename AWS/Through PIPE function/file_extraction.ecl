IMPORT PYTHON3 AS Python;
MyRecord := RECORD
    STRING first_column;//just keep this a string
   
END;    //you can define an arbitrary record structure for just the extraction process 

STRING regular := '.output_file_(\\d+)\\.csv..(.+)';//regular expression for files like: output_file_42.csv\410

dat := DATASET('rxt', MyRecord, csv);//dataset under use
STRING file_name := '48';

r := RECORD
    STRING reg;  //introduce a new column to just store the file name/number
    STRING first_column;  
END;
r tra(dat l) := TRANSFORM//apply the transform based on flags to remove the file_name_strings appearing in the first column and shifting them into a new 'reg' column
SELF.reg := REGEXFIND(regular, l.first_column, 1);
SELF.first_column := IF(REGEXFIND(regular, l.first_column, 2)='', l.first_column,REGEXFIND(regular, l.first_column, 2));
SELF:= L;
END;

myDS := PROJECT(dat, tra(LEFT));

SET OF INTEGER indices(STREAMED DATASET(MyRecord) my_data, STRING file_number) := EMBED(Python)//iterate to find the index of the file number and index at which the file content of the specified file number stops
  c=0
  t=0
  for i in my_data:
      
      if (i[0] == file_number and i[0] != ''):
              c = c+1
              continue
      if (c>0 and i[0] == ''):
          c=c+1
          continue
      if (c>0 and i[0] != ''):
          break
      t = t+1
  return [t,c]
ENDEMBED;

INTEGER s := indices(myDS, file_name)[1]; //start index
INTEGER e := indices(myDS, file_name)[2]; //end index
STREAMED DATASET(MyRecord) extract_from_indices(STREAMED DATASET(MyRecord) my_data,INTEGER n1, INTEGER n2) := EMBED(Python)//extract the dataset from indices
cnt = 0
l=[]
for dat in my_data:
    cnt = cnt+1
    if (cnt>= n1 and cnt<=n2):
          l.append(dat)
return l
ENDEMBED;

OUTPUT(extract_from_indices(myDS[2..], s+1, s+e), NAMED('FILE_NAME_EXTRACTED'));//this is the final extracted file
//you can check the folder_sprayed.csv file to see how a file like 'dat' looks like.

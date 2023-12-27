rec := RECORD
    STRING c1;
    STRING prim_key;
    STRING Book_ID;
    STRING Book_Name; 
    //record structure

END;
STRING regular := '.(output_file_\\d+).csv..(.+)';//regular expression for files like: output_file_42.csv\410

dat := DATASET('rxt', rec, csv);//the sprayed folder
OUTPUT(dat, NAMED('SPRAYED_FOLDER'));
STRING file_name := 'output_file_4';

regular_on_ds := REGEXFIND(regular, dat.c1, 1);
r := RECORD
    STRING reg;  //introduce a new column to just store the file name/number
    STRING C1;  
    STRING prim_key;
    STRING Book_ID;
    STRING Book_Name;
END;

r tra(dat l) := TRANSFORM
SELF.reg := REGEXFIND(regular, l.c1, 1);
SELF.c1 := IF(REGEXFIND(regular, l.c1, 2)='', l.c1,REGEXFIND(regular, l.c1, 2));
SELF := l;
END;

myDS := PROJECT(dat, tra(LEFT));
myDS;


IMPORT PYTHON3 AS Python;

SET OF INTEGER indices(STREAMED DATASET(r) my_data, STRING file_number) := EMBED(Python)
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
OUTPUT(s, NAMED('INDEX_OF_START'));
OUTPUT(e, NAMED('INDEX_OF_END'));


INTEGER start := s +1;
INTEGER ending := s + e;
OUTPUT(myDS[start..ending], NAMED('THE_EXTRACTED_FILE'));//selected file is the output
OUTPUT(myDS,,'tested::spray',NAMED('FILE_HAS_BEEN_SPRAYED'), OVERWRITE);//spraying the modifications back to the cluster

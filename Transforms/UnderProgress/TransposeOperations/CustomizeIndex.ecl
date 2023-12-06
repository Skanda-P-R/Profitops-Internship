#OPTION('obfuscateOutput',TRUE);

IMPORT STD;
IMPORT $;

MyString := RECORD
  STRING var;
END;

InputRec:= RECORD
  STRING field;
  STRING val;
END;

InputDS:= DATASET([{'Name','Iris'},{'Color','White'},{'Color','Green'},{'ID','12543'},
                    {'Name','Sunflower'},{'Color','Yellow'},{'ID','42351'}, {'Name','Jasmine'},
                     {'Name','Hibiscus'},{'Color','Red'},{'ID','24315'},{'Color','Pink'}],InputRec);
                     
InputDS;

OffsetRec:= RECORD
  INTEGER val;
END;

OffsetRec GetOffset(INTEGER x):= TRANSFORM
  SELF.val:= IF(InputDS[x].field='Name',x,SKIP);
END;

Offset:= PROJECT(InputDS,GetOffset(COUNTER));
//Offset := Offset + DATASET([{COUNT(InputDS)}],OffsetRec);
OUTPUT(Offset);
OUTPUT(COUNT(InputDS));
/*
INTEGER x:= 1;
INTEGER y:= 6;
OUTPUT(InputDS[1..6]);

MyTemp:= DATASET([''],MyString);

MyOP:= LOOP(MyTemp,
      y-x,
         PROJECT(ROWS(LEFT), 
                  TRANSFORM(MyString,
                            SELF.var:= IF(InputDS[COUNTER+x].field='ID', InputDS[COUNTER+x].val,LEFT.var))) );
OUTPUT(MyOP);
*/

MyOutputRec:= RECORD
  STRING Name;
  DATASET(MyString) Color;
  STRING ID;
END;

MyOutputRec GetOutput(INTEGER x, INTEGER y):= TRANSFORM
  SELF.Name:= InputDS[x].val;
  SELF.Color := LOOP(DATASET([],MyString),
                y-x,
                ROWS(LEFT)+IF(InputDS[COUNTER+x].field='Color', DATASET([InputDS[COUNTER+x].val],MyString)) );
  SELF.ID:= LOOP(DATASET([],MyString),
                 y-x,
                 ROWS(LEFT)+ IF(InputDS[COUNTER+x].field='ID', DATASET([InputDS[COUNTER+x].val],MyString)) )[1].var;
END;

MyAns:= PROJECT(Offset,GetOutput(Offset[COUNTER].val,IF(COUNTER!=COUNT(Offset),Offset[COUNTER+1].val, COUNT(InputDS))));

MyAns;

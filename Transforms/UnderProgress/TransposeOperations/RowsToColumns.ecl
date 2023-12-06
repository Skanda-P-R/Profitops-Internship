#OPTION('obfuscateOutput',TRUE);

IMPORT Std.Str;

MyString:= {String var};

My3String:= RECORD
  STRING name;
  STRING Title;
  STRING Office;
END;


MyData := DATASET([{'Employee: Karen Chiu'},{'Job title: Senior analyst'},{'Office: New York'},
                    {'Employee: Joe Curey'},{'Job title: Junior Analyst'},{'Office: Beijing'},
                    {'Employee: Samantha Martin'},{'Job title: CEO'},{'Office: Tokyo'}],MyString);

MyData;

MyData1:= MyData(Str.StartsWith(var,'Employee'));
MyData2:= MyData(Str.StartsWith(var,'Job'));
MyData3:= MyData(Str.StartsWith(var,'Office'));

My3String FetchData(INTEGER x):= TRANSFORM
  SELF.name := MyData1[x].var;
  SELF.Title := MyData2[x].var;
  SELF.Office := MyData3[x].var;
END;

OutputData:= PROJECT(MyData1,FetchData(COUNTER));
OutputData;

//COUNT(MyData);
/*
My3String Transformer(INTEGER x):= TRANSFORM
  x:=x+3;
  SELF.name:= CHOOSEN(MyData,1,x);
  SELF.Title:= CHOOSEN(MyData,1,x+1);
  SELF.Office:= CHOOSEN(MyData,1,x+2);
END;
*/
//FormattedData:= PROJECT([],Transformer(1));
//FormattedData:= CHOOSEN(MyData,3);
//NextData:= CHOOSEN(MyData,3,4);

/*
My3String Transformer([String var] x,[String var] y,[String var] z):= TRANSFORM
  SELF.name:= x.var;
  SELF.Title:= y.var;
  SELF.Office:= z.var;
END;
*/
//JOIN
//FormattedData:= TABLE(MyData1,MyData2,MyData3);

/*
MyOutput:= RECORD
  DATASET(MyString) name;
  DATASET(MyString) Title;
  DATASET(MyString) Office;
END;

Formatted:= DATASET([{MyData1,MyData2,MyData3}],MyOutput);
OUTPUT(Formatted);
TABLE(Formatted);
*/

/*
NewLayout:=RECORD
  String name:=Formatted.name.var;
  STRING title:= Formatted.Title.var;
  STRING office:= Formatted.Office.var;
END;
TABLE(Formatted,NewLayout);
*/


/*
STRING x:= '';
STRING y := '';
STRING z:= '';
OUTPUT(DATASET([{x},{y},{z}],MyString) );

My3String recordcreate():= 
*/
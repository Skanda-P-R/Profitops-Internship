IMPORT $;

//Incremental Data Push

db := $.Incremental_Push_Function_Definition('root','root@1234');
// db.tb_Delete();
// db.tb_Insert1();
// db.temp_tb_Insert();

// df1 := db.tb_Dataset1();
// OUTPUT(df1,,'~spr::orderv1',OVERWRITE);

// df1 := DATASET('~spr::orderv1',db.tbRecord,THOR);

// db.tb_Insert2();
df := db.tb_Update();
OUTPUT(df);

// df2 := db.tb_Dataset2();

// df3 := db.get(df1,df2);
// df4 := db.get_added(df1,df3);
// df5 := db.get_modified(df1,df2);

// OUTPUT(df1,NAMED('Original_Table'));
// OUTPUT(df3,NAMED('Updated_Table'));
// OUTPUT(df4,NAMED('Content_added'));
// OUTPUT(df5,NAMED('Content_Modified'));
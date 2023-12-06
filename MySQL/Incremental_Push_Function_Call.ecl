IMPORT $;

//Incremental Data Push

db := $.Incremental_Push_Function_Definition('root','root@1234');

// db.tb_Drop();

// db.tb_Create();

// db.tb_Insert1();

// df1 := db.tb_Dataset();
// OUTPUT(df1,,'~spr::orderv1',OVERWRITE);

// df1 := DATASET('~spr::orderv1',db.tbRecord,THOR);

// db.tb_Insert2();

// df2 := db.tb_Dataset();
// df3 := db.get(df1,df2);
// df4 := db.get_added(df1,df3);
// df5 := db.get_modified(df1,df2);

// OUTPUT(df1,NAMED('Original_Table'));
// OUTPUT(df3,,'~spr::order_modified',NAMED('Updated_Table'),OVERWRITE);
// OUTPUT(df4,NAMED('Content_added'));
// OUTPUT(df5,NAMED('Content_Modified'));
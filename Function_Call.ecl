IMPORT $;

//Create New Table

// db := $.test_dbDatabase('root','root@1234');
// db.Create_test_tb();

//Insert CSV to Table

// db := $.test_dbDatabase('root','root@1234');
// db.test_tb_InsertCSV();

//Store MySQL Table to HPCC

// db := $.test_dbDatabase('root','root@1234');
// df1 := db.test_tb_Dataset();
// OUTPUT(df1,,'~spr::test2',NAMED('MySQL_Table_CSV_Data'),OVERWRITE);

//Delete content of Table

// db := $.test_dbDatabase('root','root@1234');
// db.test_tb_Delete();

//Delete Table

// db := $.test_dbDatabase('root','root@1234');
// db.test_tb_Drop();

//Create New Table for XML Insert

// db := $.test_dbDatabase('root','root@1234');
// db.Create_tb_xml();

//Insert XML to Table

// db := $.test_dbDatabase('root','root@1234');
// db.tb_xml_InsertXML();

//Store MySQL Table to HPCC

// db := $.test_dbDatabase('root','root@1234');
// df1 := db.tb_xml_Dataset();
// OUTPUT(db.tb_xml_Dataset(),,'~spr::test3',NAMED('MySQL_Table_XML_Data'),OVERWRITE);

//Delete content of Table

// db := $.test_dbDatabase('root','root@1234');
// db.tb_xml_Delete();

//Delete Table

// db := $.test_dbDatabase('root','root@1234');
// db.tb_xml_Drop();
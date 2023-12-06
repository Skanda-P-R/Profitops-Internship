IMPORT MySql;

EXPORT test_dbDatabase(string user, string password) := MODULE

    EXPORT Create_test_tb() := EMBED(mySql : database('test_db'), user(user), password(password))
        CREATE TABLE test_tb(
        id int,
        cid float,
        pic50 float);
    ENDEMBED;
    
    EXPORT test_tbRecord := RECORD
        INTEGER4 id;
        REAL4 cid;
        REAL4 pic50;
    END;
    
    EXPORT test_tb_InsertCSV() := EMBED(mySql : database('test_db'), user(user), password(password))
        LOAD DATA LOCAL INFILE '/var/lib/HPCCSystems/mydropzone/test.csv'
        INTO TABLE test_tb
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    ENDEMBED;
    
    EXPORT DATASET(test_tbRecord) test_tb_Dataset() := EMBED(mySql : database('test_db'), user(user), password(password))
        SELECT * FROM test_tb;
    ENDEMBED;
    
    EXPORT test_tb_Delete() := EMBED(mySql : database('test_db'), user(user), password(password))
        DELETE FROM test_tb;
    ENDEMBED;
    
    EXPORT test_tb_Drop() := EMBED(mySql : database('test_db'), user(user), password(password))
        DROP TABLE test_tb;
    ENDEMBED;
    
    EXPORT Create_tb_xml() := EMBED(mySql : database('test_db'), user(user), password(password))
        CREATE TABLE tb_xml(
        ID INT NOT NULL PRIMARY KEY,
        CID FLOAT NULL,
        pIC50 FLOAT NULL
        );
    ENDEMBED;
    
    EXPORT tb_xml_InsertXML() := EMBED(mySql : database('test_db'), user(user), password(password))
        LOAD XML LOCAL INFILE '/var/lib/HPCCSystems/mydropzone/test.xml'
        INTO TABLE tb_xml
        ROWS IDENTIFIED BY '<row>';
    ENDEMBED;
    
    EXPORT DATASET(test_tbRecord) tb_xml_Dataset() := EMBED(mySql : database('test_db'), user(user), password(password))
        SELECT * FROM tb_xml;
    ENDEMBED;
    
    EXPORT tb_xml_Delete() := EMBED(mySql : database('test_db'), user(user), password(password))
        DELETE FROM tb_xml;
    ENDEMBED;
    
    EXPORT tb_xml_Drop() := EMBED(mySql : database('test_db'), user(user), password(password))
        DROP TABLE tb_xml;
    ENDEMBED;
END;
IMPORT MySql;
EXPORT Incremental_Push_Function_Definition(string user, string password) := MODULE

    EXPORT tbRecord := RECORD
        INTEGER4 order_id;
        STRING order_name;
        STRING name;
        INTEGER4 price;
    END;
    
    EXPORT tb_Create() := EMBED(mySql : database('increment'), user(user), password(password))
        CREATE TABLE tb(
        order_id INT,
        order_name VARCHAR(50),
        name VARCHAR(50),
        price INT);
    ENDEMBED;
    
    EXPORT tb_Drop() := EMBED(mySql : database('increment'), user(user), password(password))
        DROP TABLE tb;
    ENDEMBED;
    
    EXPORT tb_Insert1() := EMBED(mySql : database('increment'), user(user), password(password))
        LOAD DATA LOCAL INFILE '/var/lib/HPCCSystems/mydropzone/order v1.csv'
        INTO TABLE tb
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    ENDEMBED;
    
    EXPORT DATASET(tbRecord) tb_Dataset() := EMBED(mySql : database('increment'), user(user), password(password))
        SELECT * FROM tb;
    ENDEMBED;
    
    EXPORT tb_Insert2() := EMBED(mySql : database('increment'), user(user), password(password))
        LOAD DATA LOCAL INFILE '/var/lib/HPCCSystems/mydropzone/order v2.csv'
        INTO TABLE tb
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    ENDEMBED; 
    
    EXPORT DATASET(tbRecord) get(DATASET(tbRecord) df1, DATASET(tbRecord) df2) := FUNCTION
     df3 := JOIN(df1,SORT(df2,order_id,order_name),LEFT.order_id=RIGHT.order_id,
                  TRANSFORM(tbRecord,
                  SELF := RIGHT,
                  SELF := LEFT),
                  RIGHT OUTER);
     df4 := DEDUP(df3,order_id);   
     return df4;
    END;
    
    EXPORT DATASET(tbRecord) get_added(DATASET(tbRecord) df1, DATASET(tbRecord) df2) := FUNCTION
      df3 := JOIN(df1,df2,LEFT.order_id=RIGHT.order_id,
                  TRANSFORM(tbRecord,
                  SELF := RIGHT,
                  SELF := LEFT),
                  RIGHT ONLY);
     return df3;
    END;
    
    EXPORT DATASET(tbRecord) get_modified(DATASET(tbRecord) df1, DATASET(tbRecord) df2) := FUNCTION
     df3 := JOIN(df1,df2,LEFT.order_id=RIGHT.order_id AND LEFT.order_name<>RIGHT.order_name,
                  TRANSFORM(tbRecord,
                  SELF := RIGHT,
                  SELF := LEFT),
                  INNER);
     return df3;    
    END;
END;

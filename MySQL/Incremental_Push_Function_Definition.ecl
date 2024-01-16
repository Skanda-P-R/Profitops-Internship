IMPORT MySql;
EXPORT Incremental_Push_Function_Definition(string user, string password) := MODULE

    EXPORT tbRecord := RECORD
        INTEGER4 order_id;
        STRING order_name;
        STRING name;
        INTEGER4 price;
        STRING created_date;
        STRING updated_date := ' ';
    END;
    
    EXPORT rec := RECORD
        INTEGER4 order_id;
        STRING order_name;
        STRING name;
        INTEGER4 price;
        STRING created_date;
    END;
    
    EXPORT tb_Create() := EMBED(mySql : database('increment'), user(user), password(password))
        CREATE TABLE tb(
        order_id INT,
        order_name VARCHAR(50),
        name VARCHAR(50),
        price INT,
        created_date VARCHAR(50),
        updated_date VARCHAR(50));
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
     
     df3 date(df3 Le,df3 Ri) := TRANSFORM
     SELF.order_name := Ri.order_name;
     SELF.created_date := IF(Le.order_id=Ri.order_id,le.created_date,ri.created_date);
     SELF.updated_date := IF(Le.order_id=Ri.order_id,Ri.created_date,' ');
     SELF := Ri;
     END;
     
     df4 := ITERATE(df3,date(LEFT,RIGHT));   
     
     df4 date2(df4 Le,df4 Ri) := TRANSFORM
     SELF.order_name := IF(Le.order_id=Ri.order_id,le.order_name,ri.order_name);
     SELF.price := IF(Le.order_id=Ri.order_id,le.price,ri.price);
     SELF.created_date := IF(Le.order_id=Ri.order_id,ri.updated_date,ri.created_date);
     SELF.updated_date := IF(Le.order_id=Ri.order_id,ri.created_date,' ');
     SELF := Ri;
     END;
     
     df5 := ITERATE(df4,date2(LEFT,RIGHT));
     return DEDUP(SORT(df5,order_id,-updated_date),order_id);
    END;
    
    EXPORT DATASET(rec) get_added(DATASET(tbRecord) df1, DATASET(tbRecord) df2) := FUNCTION
      df3 := JOIN(df1,df2,LEFT.order_id=RIGHT.order_id,
                  TRANSFORM(tbRecord,
                  SELF := RIGHT,
                  SELF := LEFT),
                  RIGHT ONLY);
      
     rec := RECORD
        df3.order_id;
        df3.order_name;
        df3.name;
        df3.price;
        df3.created_date;
    END;
      
     return TABLE(df3,rec);
    END;
    
    EXPORT DATASET(rec) get_modified(DATASET(tbRecord) df1, DATASET(tbRecord) df2) := FUNCTION
     df3 := JOIN(df1,df2,LEFT.order_id=RIGHT.order_id AND LEFT.order_name<>RIGHT.order_name,
                  TRANSFORM(tbRecord,
                  SELF := RIGHT,
                  SELF := LEFT),
                  INNER);
     rec := RECORD
        df3.order_id;
        df3.order_name;
        df3.name;
        df3.price;
        df3.created_date;
    END;
      
     return TABLE(df3,rec);   
    END;
END;

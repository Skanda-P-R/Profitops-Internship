IMPORT $;

//INTEGER x:= 2;


//head:= '~class::ssd::intro::p';
//tail:= '-samplecsv.csv';
//temp:= head+x+tail;
//OUTPUT(temp,NAMED('path'));
//csvdata1:= $.CSVExtractorRecord(temp).File;
//OUTPUT(csvdata1,NAMED('SrcCSV1'));

EXPORT CSVSerialCombiner(INTEGER x, STRING head='',STRING tail=''):= MODULE
    EXPORT File:= LOOP(DATASET([],$.CSVExtractorRecord.Layout),x,
                      ROWS(LEFT) + DATASET(head+COUNTER+tail,$.CSVExtractorRecord.Layout,CSV(HEADING(1))));
END;


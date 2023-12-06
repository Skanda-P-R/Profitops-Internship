IMPORT $;

//INTEGER x:= 2;


//head:= '~class::ssd::intro::p';
//tail:= '-samplecsv.csv';
//temp:= head+x+tail;
//OUTPUT(temp,NAMED('path'));
//csvdata1:= $.CSVExtractorRecord(temp).File;
//OUTPUT(csvdata1,NAMED('SrcCSV1'));

EXPORT CSVCombiner(SET OF STRING s):= MODULE
    EXPORT File:= LOOP(DATASET([],$.CSVExtractorRecord.Layout),COUNT(s),
                      ROWS(LEFT) + DATASET(s[COUNTER],$.CSVExtractorRecord.Layout,CSV(HEADING(1))));
END;

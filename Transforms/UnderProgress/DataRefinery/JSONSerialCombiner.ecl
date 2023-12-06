IMPORT $;

//head:= '~class::ssd::intro::p';
//tail:= '-samplejson.json';

EXPORT JSONSerialCombiner(INTEGER x, INTEGER offset=0, STRING head='',STRING tail=''):= MODULE
    EXPORT File:= LOOP(DATASET([],$.JSONExtractorRecord.Layout),x,
                      ROWS(LEFT) + DATASET(head+COUNTER+tail,$.JSONExtractorRecord.Layout,JSON('/')));
END;


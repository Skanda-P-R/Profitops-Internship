IMPORT $;

//head:= '~class::ssd::intro::p';
//tail:= '-samplexml.xml';

EXPORT XMLSerialCombiner(INTEGER x, INTEGER offset=0, STRING head='',STRING tail=''):= MODULE
    EXPORT File:= LOOP(DATASET([],$.XMLExtractorRecord.Layout),x,
                      ROWS(LEFT) + DATASET(head+COUNTER+tail,$.XMLExtractorRecord.Layout,XML('Shipments/Shipment')));
END;

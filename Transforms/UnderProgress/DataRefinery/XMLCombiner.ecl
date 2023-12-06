IMPORT $;

EXPORT XMLCombiner(SET OF STRING s):= MODULE
    EXPORT File:= LOOP(DATASET([],$.XMLExtractorRecord.Layout),COUNT(s),
                      ROWS(LEFT) + DATASET(s[COUNTER],$.XMLExtractorRecord.Layout,XML('Shipments/Shipment')));
END;

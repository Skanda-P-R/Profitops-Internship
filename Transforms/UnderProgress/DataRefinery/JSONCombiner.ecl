IMPORT $;

EXPORT JSONCombiner(SET OF STRING s):= MODULE
    EXPORT File:= LOOP(DATASET([],$.JSONExtractorRecord.Layout),COUNT(s),
                      ROWS(LEFT) + DATASET(s[COUNTER],$.JSONExtractorRecord.Layout,JSON('/')));
END;

IMPORT STD;
import $;

rec := $.RecordDefs.rec;

STRING regular := '.(output_file_.+).csv(.+)';//regular expression for files like: output_file_42.csv\410

dat := DATASET('em::new_job', rec, csv);//the sprayed folder
OUTPUT(dat, NAMED('SPRAYED_FOLDER'));
STRING file_name := 'output_file_4';

regular_on_ds := REGEXFIND(regular, dat.c1, 1);
r := RECORD
    STRING reg;  //introduce a new column to just store the file name/number
    rec;
END;

r tra(dat l) := TRANSFORM
SELF.reg := REGEXFIND(regular, l.c1, 1);
SELF.c1 := IF(REGEXFIND(regular, l.c1, 2)='', l.c1,REGEXFIND(regular, l.c1, 2));
SELF := l;
END;

myDS := PROJECT(dat, tra(LEFT));
myDS;

r tr(myDS l, myDS r) := TRANSFORM
SELF.reg := IF(R.reg = '', L.reg, R.reg);
SELF := R;
END;

t := ITERATE(myDS, TR(LEFT, RIGHT));
t;
OUTPUT(myDS,, '~hthor::AATR',CSV( SEPARATOR(','), TERMINATOR('\n')),NAMED('SPRAYED_FILE'),OVERWRITE);

STD.File.DeSpray('~hthor::AATR','10.0.2.15','bkt_desprayed/this_is_a_test_177.csv');//despray the file on the cluster

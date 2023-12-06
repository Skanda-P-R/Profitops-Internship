IMPORT $;
IMPORT std.Str;

/*
myrec := {REAL diff, INTEGER1 reason};
rms5008 := 10.0;
rms5009 := 11.0;
rms5010 := 12.0;
btable := DATASET([{rms5008,72},{rms5009,7},{rms5010,65}], myrec);
OUTPUT(btable);
*/

R1:= RECORD
  VARSTRING name;
END;

xtable := DATASET([{'hello  there '},{'  general  kenobi'}], R1);

//OUTPUT(xtable);

OPR1 := RECORD
  VARSTRING name;
  VARSTRING formatted;
  INTEGER1 x; 
END;

OPR1 trimmer(R1 rec):= TRANSFORM
  temp := str.CleanSpaces(rec.name);
  SELF.formatted := temp;
  SELF.x := LENGTH(rec.name)-LENGTH(temp); //shows number of whitespaces deleted by the function
  SELF := rec;
END;

Res := PROJECT(xtable, trimmer(LEFT));

OUTPUT(Res);



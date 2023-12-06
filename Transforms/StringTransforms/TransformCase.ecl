IMPORT $;
IMPORT std.str;

R1:= RECORD
  STRING name;
END;

xtable := DATASET([{'hElLo TheRe.'},{'MineRaL'},{'It iS I, diO.'},{'pause. nOw Resume. tHEN PAUSE again.'}], R1);

OPR1 := RECORD
  STRING Name;
  STRING Lower;
  STRING Upper;
  STRING Title;
END;

OPR1 formatter(R1 rec):= TRANSFORM
  SELF.Lower := str.toLowerCase(rec.name);
  SELF.Upper := str.toUpperCase(rec.name);
  SELF.Title := str.toTitleCase(rec.name);
  SELF := rec;
END;

Res := PROJECT(xtable, formatter(LEFT));

OUTPUT(Res);

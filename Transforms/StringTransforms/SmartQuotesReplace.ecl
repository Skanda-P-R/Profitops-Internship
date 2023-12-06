#OPTION('obfuscateOutput',TRUE);
IMPORT $;
IMPORT std.Uni;

R1:= RECORD
  UNICODE name;
END;

xtable := DATASET([{u'\u276ehello  there \u201f'},{u'\uff07  general  kenobi\u301e \" '},{u'\u201d\u201c\u201ei am here\u301d'},{u'\u201d\u201b\u2019i am here\u203a'},{'June $# 2nd 2023,'}], R1);

//OUTPUT(xtable);

OPR1 := RECORD
  UNICODE name;
  UNICODE formatted;
END;

OPR1 replacer(R1 rec):= TRANSFORM
  temp := Uni.SubstituteIncluded(rec.name,u'\u0022\u201f\u201e\u201d\u201c\uff02\u301e\u301d\u301f\u2e32\u00ab\u00bb\u275e\u275d' ,  '\"');  
  //replace all unicode double quote characters with the ASCII equivalent
  SELF.formatted := Uni.SubstituteIncluded(temp, u'\uff07\u275c\u275f\u275b\u203a\u2039\u276e\u276f\u201b\u2019\u2018\u201a' , '\'' );
  //replace all unicode single quote characters with the ASCII equivalent  
  SELF := rec;
END;

Res := PROJECT(xtable, replacer(LEFT));


OUTPUT(Res);
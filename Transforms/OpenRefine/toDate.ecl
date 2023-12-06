IMPORT STD;
EXPORT toDate(String unformat_date) := FUNCTION
  temp:= STD.Str.ToLowerCase(Std.str.SubstituteExcluded(unformat_date,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',' '));
  x1 := STD.str.findReplace(temp,'th',' ');
  x2 := STD.str.findReplace(x1,'rd',' ');
  x3 := STD.str.findReplace(x2,'nd',' ');
  x4 := STD.str.findReplace(x3,'1st','1 ');
  date:=STD.Str.cleanSpaces(x4);
  YMD:=STD.Date.FromStringToDate(date, '%Y %m %d')+STD.Date.FromStringToDate(date, '%Y %b %d');
  MDY :=STD.Date.FromStringToDate(date, '%m %d %Y')+STD.Date.FromStringToDate(date, '%b %d %Y');
  DMY :=STD.Date.FromStringToDate(date, '%d %m %Y')+STD.Date.FromStringToDate(date, '%d %b %Y');
  Return MAP(
    STD.Date.IsValidDate(YMD)=>(STRING)YMD,
    STD.Date.IsValidDate(MDY)=>(STRING)MDY,
    STD.Date.IsValidDate(DMY)=>(STRING)DMY,
    unformat_date
  );
END;
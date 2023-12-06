IMPORT STD;
EXPORT toTime(STRING unformat_time) := FUNCTION
  temp:= STD.Str.ToLowerCase(Std.str.SubstituteExcluded(unformat_time,'0123456789',' '));  
  time:=STD.Str.cleanSpaces(temp);
  HMS :=STD.Date.FromStringToTime(time, '%H %M %S');
    HM :=STD.Date.FromStringToTime(time, '%H %M');
    check:=IF(STD.Str.Find(STD.Str.ToLowerCase(unformat_time), 'pm', 1) = 0,
   false,
   true);
    offset:= IF( (check and HMS<120000 and HM<120000),
   120000,
   0);
   HMSE:=HMS+offset;
   HME:=HM+offset;
    return  MAP(
        (STD.Date.IsValidTime(HMSE) and HMSE<>0) =>(STRING)HMSE,
        (STD.Date.IsValidTime(HME) and HME<>0) => (STRING)HME,
        unformat_time
    );
END;
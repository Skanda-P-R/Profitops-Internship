IMPORT STD;
EXPORT toCurrency(String curr) := Function
val:=STD.Str.Filter(curr, '1234567890.e');
  amount:=if((REAL4)val<>0,
    (REAL4)val,
    (REAL4)STD.Str.FilterOut(val, 'e')
  );
  return if(STD.Str.StartsWith(curr,'(') and STD.STr.EndsWith(curr,')'),
    -amount,
    amount
  ); 
END;
IMPORT STD;
EXPORT toCurrency(String curr) := Function
val:=STD.Str.Filter(curr, '1234567890.e');
  amount:=if((REAL)val<>0,
    (REAL)val,
    (REAL)STD.Str.FilterOut(val, 'e')
  );
  return if(STD.Str.StartsWith(curr,'(') and STD.STr.EndsWith(curr,')'),
    -amount,
    amount
  ); 
END;
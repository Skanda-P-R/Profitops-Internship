#OPTION('obfuscateOutput',TRUE);

IMPORT $;

layout := RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
END;

outputds:= $.temp.func();
outputds;


ds := DATASET([
    {'Jacques Cousteau', '23 quai de Conti', 'Paris', '', 'France', '75270'},
    {'Emmy Noether', '010 N Merion Avenue', 'Bryn Mawr', 'Pennsylvania', 'USA', '19010'}
], layout);
ds;

output2:= PROJECT(ds,$.temp.Convert(LEFT,2,3));
OUTPUT(output2);

/*
AddrLayout:= RECORD
  STRING addr_field;
  STRING addr_name;
END;

OutputLayout:= RECORD
  STRING name;
  DATASET(AddrLayout) addr; 
END;

OutputLayout Convert(layout rec):= TRANSFORM
  SELF.name := rec.name;
  temp1:=  IF(rec.street!='', DATASET([{'Street',rec.street}],AddrLayout),DATASET([],AddrLayout));
  temp2:=  IF(rec.city!='', DATASET([{'City',rec.city}],AddrLayout),DATASET([],AddrLayout));
  temp3:=  IF(rec.State!='', DATASET([{'State',rec.State}],AddrLayout),DATASET([],AddrLayout));
  temp4:=  IF(rec.country!='', DATASET([{'Country',rec.country}],AddrLayout),DATASET([],AddrLayout));
  temp5:=  IF(rec.postalCode!='', DATASET([{'Postal Code',rec.postalCode}],AddrLayout),DATASET([],AddrLayout));
  SELF.addr:= temp1+temp2+temp3+temp4+temp5;
END;

Outputrec:= PROJECT(ds,Convert(left));

Outputrec;
*/
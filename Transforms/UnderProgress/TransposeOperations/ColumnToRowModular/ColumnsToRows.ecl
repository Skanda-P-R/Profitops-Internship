//#OPTION('obfuscateOutput',TRUE);

IMPORT $;
IMPORT std.DataPatterns;
IMPORT Python3 AS Python;

layout := RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
END;

/*ds := DATASET([
    {'Jacques Cousteau', '23 quai de Conti', 'Paris', '', 'France', '75270'},
    {'Emmy Noether', '010 N Merion Avenue', 'Bryn Mawr', 'Pennsylvania', 'USA', '19010'}
], layout);
*/

ds := DATASET('~class::ssd::transpose::fake_data', layout, CSV(Heading(1)));

OUTPUT(ds,NAMED('Input'));

op2ds:= $.TransposeOneColumn(ds,2,6).opds;
OUTPUT(op2ds,NAMED('ToOneColumn'));

op4ds:= $.TransposeOneColumnWithName(ds,2,6).opds;
OUTPUT(op4ds,NAMED('ToOneColumnWithName'));

op3ds:= $.TransposeTwoColumns(ds,2,6).opds;
OUTPUT(op3ds,NAMED('ToTwoColumns'));

tempds:= DATASET(ds[1]);  //do not pass non-empty dataset
data_pattern := $.GetDataPatterns(tempds);
OUTPUT(data_pattern.data_ds);

OUTPUT(ds[200..500]);

/*
INTEGER inputsize:= data_pattern.max_len;

transpose_layout:= RECORD
  STRING var;
END;

output_layout:= RECORD
    STRING name;
    DATASET(transpose_layout) addr; 
  END;

DATASET(transpose_layout) ExtractData(layout arr, INTEGER start_index, INTEGER end_index, INTEGER max_len=inputsize):= EMBED(Python)
  if(end_index>max_len):
    return []
  opar = []
  i=1
  for item in arr:
    if(i>=start_index and i<=end_index):
      opar.append(item)
    i=i+1
  return opar
ENDEMBED;


output_layout ColToRow(layout le):= TRANSFORM
  SELF.addr:= ExtractData(le, 2,6,inputsize);
  SELF:= le;
END;

opds:= PROJECT(ds,ColToRow(LEFT));
opds;
*/
//op2ds:= PROJECT(ds, $.TransposeOneColumn.ColToRow(LEFT,2,5,inputsize));

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
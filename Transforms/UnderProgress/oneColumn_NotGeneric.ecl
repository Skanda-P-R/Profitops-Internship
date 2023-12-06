layout := RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
END;

AddressLayout := RECORD
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
END;

new_layout := RECORD
    STRING name;
    DATASET(AddressLayout) address;
END;

ds := DATASET([
    {'Jacques Cousteau', '23 quai de Conti', 'Paris', '', 'France', '75270'},
    {'Emmy Noether', '010 N Merion Avenue', 'Bryn Mawr', 'Pennsylvania', 'USA', '19010'}
], layout);

ds;

new_layout OneColumn(ds l):=Transform 
self.name:=l.name;
self.address:=DATASET(ROW(L,AddressLayout));
END;

oneColumnFile:=Project(ds,OneColumn(left));
oneColumnFile;

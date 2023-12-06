IMPORT Python3 AS Python;
layout := RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
END;

ds := DATASET([
    {'Jacques Cousteau', '23 quai de Conti', 'Paris', '', 'France', '75270'},
    {'Emmy Noether', '010 N Merion Avenue', 'Bryn Mawr', 'Pennsylvania', 'USA', '19010'}
], layout);
ds;
AddressLayout := RECORD
    STRING addr;
END;

new_layout := RECORD
    STRING name;
    DATASET(AddressLayout) address;
END;



Dataset(new_layout) ToOneColumn(Dataset(layout) arr,start_index,end_index) := EMBED(Python)
  grouped_arr = [
      (*item[:start_index], [*item[start_index:end_index],], *item[end_index:])
      for item in arr
  ]
  return grouped_arr
ENDEMBED;

ToOneColumn(ds,1,6);
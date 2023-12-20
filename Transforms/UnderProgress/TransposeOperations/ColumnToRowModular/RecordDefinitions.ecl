/*
DEfine the input layout and output layout structures here for usage in other transposing functions.
DO NOT MODIFY the RECORD structure of temp_layout
*/

EXPORT RecordDefinitions := MODULE;

  EXPORT input_layout:= RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
  END;
  
  EXPORT temp_layout:= RECORD
    STRING var;
  END;
  
  EXPORT output_layout:= RECORD
    STRING name;
    DATASET(temp_layout) addr; 
  END;
  
  EXPORT output2_layout:= RECORD
    STRING name;
    DATASET(temp_layout) field;
    DATASET(temp_layout) addr;
  END;
  
END;

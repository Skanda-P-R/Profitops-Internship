EXPORT RecordDefinitions := MODULE;
  EXPORT input_layout:= RECORD
    STRING name;
    STRING street;
    STRING city;
    STRING State;
    STRING country;
    STRING postalCode;
  END;
  
  EXPORT output_layout:= RECORD
    STRING name;
    DATASET({STRING var}) addr; 
  END;

END;

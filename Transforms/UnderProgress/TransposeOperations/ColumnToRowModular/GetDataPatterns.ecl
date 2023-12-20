/*
This code is used to obtain useful insights from the DataPatterns Profile of the input_record dataset
FOR EFFICIENCY, pass only the first row of your input_record DATASET to this module.
*/

IMPORT $;
IMPORT std.DataPatterns;


EXPORT GetDataPatterns(DATASET($.RecordDefinitions.input_layout) arr) := MODULE;
  EXPORT data_ds:= DataPatterns.Profile(arr);
  
  
  $.RecordDefinitions.temp_layout GetAttrNames(RECORDOF(data_ds) le):= TRANSFORM
    SELF.var:= le.attribute;
  END;
  EXPORT field_ds:= PROJECT(data_ds,GetAttrNames(LEFT));
  EXPORT max_len:= COUNT(field_ds);
  
END;

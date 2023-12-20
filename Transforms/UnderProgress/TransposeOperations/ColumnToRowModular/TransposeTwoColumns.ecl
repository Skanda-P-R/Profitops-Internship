IMPORT $;
IMPORT Python3 AS Python;
IMPORT std.DataPatterns;

EXPORT TransposeTwoColumns(DATASET($.RecordDefinitions.input_layout) arr, INTEGER start_index, INTEGER end_index) := MODULE
  
  data_pattern := $.GetDataPatterns(DATASET(arr[1]));
  fields:= data_pattern.field_ds;
  
  DATASET($.RecordDefinitions.temp_layout) ExtractData($.RecordDefinitions.input_layout arr, INTEGER start_index, INTEGER end_index, INTEGER max_len):= EMBED(Python)
  if(end_index>max_len):
    return []
  opar = []
  i=1
  for item in arr:
    if(i>=start_index and i<=end_index and (item!='')):
      opar.append(item)
    i=i+1
  return opar
  ENDEMBED;

  DATASET($.RecordDefinitions.temp_layout) ExtractFields($.RecordDefinitions.input_layout arr, DATASET($.RecordDefinitions.temp_layout) arr2, INTEGER start_index, INTEGER end_index, INTEGER max_len):= EMBED(Python)
  if(end_index>max_len):
    return []
  opar = []
  i=1
  for item in arr2:
    if(i>=start_index and i<=end_index and (arr[i-1]!='')):
      opar.append(item)
    i=i+1
  return opar
  ENDEMBED;

  $.RecordDefinitions.output2_layout ColToRow($.RecordDefinitions.input_layout le):= TRANSFORM
    SELF.addr:= ExtractData(le, start_index, end_index, data_pattern.max_len);
    SELF.field:= ExtractFields(le, fields, start_index, end_index, data_pattern.max_len);
    SELF:= le;
  END;
  
  EXPORT opds:= PROJECT(arr, ColToRow(LEFT));

END;
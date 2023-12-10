IMPORT Python3 AS Python;

layout := RECORD
    STRING fields;
    STRING val;
END;

new_layout := RECORD 
    STRING name;
    STRING id;
    STRING color;
    String petals;
END;

ds := DATASET([
    {'Name', 'Galanthus nivalis'}, {'id', '162168'}, {'color', 'White'},{'petals','5'},
    {'Name', 'Narcissus cyclamineus'}, {'id', '161899'}, {'color', 'Yellow'},{'petals','4'}
], layout);

ds;

Dataset(new_layout) key_value(Dataset(layout) arr) := EMBED(Python)
  data_dict = {}
  max_len = 0

  for field, value in arr:
      if field not in data_dict:
          data_dict[field] = []
      data_dict[field].append(value)
      max_len = max(max_len, len(data_dict[field]))

  result_data = []
  for i in range(max_len):
      item = tuple(data_dict[field][i] if field in data_dict and i < len(data_dict[field]) else None for field in data_dict.keys())
      result_data.append(item)

  return result_data

ENDEMBED;

key_value(ds);

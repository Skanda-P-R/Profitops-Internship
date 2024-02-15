import json
import re

datatype_mapping = {
    'integer': 'INTEGER',
    'long': 'INTEGER',
    'double': 'DECIMAL',
    'string': 'STRING', 
    'boolean': 'BOOLEAN'
}

def preprocess_name(input_string):
    result = re.sub(r'[^a-zA-Z0-9]', '_', input_string)
    return result

def schema_to_record(fields):
    ecl_fields = []
    for field in fields:
        if isinstance(field['type'], dict):
            ecl_fields.append(f"DATASET({schema_to_record(field['type']['elementType']['fields'])}) {preprocess_name(field['name'])}{{xpath('{field['name']}')}} \n")
        else:
            ecl_fields.append(f"{datatype_mapping[field['type']]} {preprocess_name(field['name'])}{{xpath('{field['name']}')}}\n")
    return "{"+','.join(ecl_fields)+"}"

json_file_path = 'dispose/Shipment-schema.json'
output_ecl_file_path = 'dispose/schema.ecl'

with open(json_file_path, 'r') as file:
    json_data = json.load(file)

result = schema_to_record(json_data['fields'])

with open(output_ecl_file_path, 'w') as output_file:
    output_file.write(result)

print(f"Schema ECL written to {output_ecl_file_path}")

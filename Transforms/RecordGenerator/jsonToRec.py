def convert_json_to_ecl(json_data):
    ecl_fields = []

    for key, value in json_data.items():
        if isinstance(value, dict):
            sub_fields = f"DATASET({convert_json_to_ecl(value)}) {key}"
            ecl_fields.append(sub_fields)
        else:
            ecl_fields.append(f"{value} {key}")

    return "{"+','.join(ecl_fields)+"}"

# Example 2
json_data_2 = {
	"Name": "STRING",
	"Birthday": "STRING",
	"Age": "INTEGER",
	"Address": 
		{
		"Location": "STRING",
		"PINCODE": "INTEGER",
		"Residents":
			{
			"IDs": "INTEGER"
			}
		},
	"Education":
		{
		"Institute": "STRING"
		}		      
}

ecl_output_2 = convert_json_to_ecl(json_data_2)
print(ecl_output_2)

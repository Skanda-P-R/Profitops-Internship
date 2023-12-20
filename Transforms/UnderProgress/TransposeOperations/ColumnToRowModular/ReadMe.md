This section contains ECL code meant to handle transpose column to rows operation. 
The code has been structured in a modular fashion so that minimal editing is needed to use it for handling different datasets with different record structures.

For any kind of Transpose operation, modify the input_layout under the RecordDefinitions.ecl file as per your requirement.
To Transpose multiple columns to a single column for every row, modify the output_layout under the RecordDefinitions.ecl file.
To Transpose multiple columns to two columns for every row, modify the output2_layout under the RecordDefinitions.ecl file.
DO NOT modify temp_layout under RecordDefinitions.ecl file.

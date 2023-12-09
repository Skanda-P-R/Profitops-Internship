
rec_set := RECORD
  STRING prim; 
  STRING val; 
  STRING AGE;
  
END;

original := DATASET('orig::orig.csv', rec_set, csv);
modified := DATASET('mod::mod.csv', rec_set, csv);
OUTPUT(original, NAMED('ORIGINAL'));
OUTPUT(modified, NAMED('MODIFIED'));


j := JOIN(modified , original,left.prim = right.prim, FULL ONLY);//THIS CAN BE USED TO RETRIEVE DELETED RECORDS

x1 := JOIN(modified, original, left.prim = right.prim AND (left.val <> right.val OR left.age <> right.age), INNER);//GENERATE CHANGED DATA


final_incremented_data := JOIN(j, x1, left.prim = right.prim, FULL OUTER);//FINAL_DIFF_FILE THAT HAS MODIFIED ROWS -> ADDED/MODIFIED/DELETED
final_incremented_data;
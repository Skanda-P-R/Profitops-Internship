IMPORT STD,$;
Layout := RECORD
    STRING curr;
END;

// File := DATASET('~ profit::transform::money::sample money-2.csv', Layout, CSV(HEADING(1)));
File:=Dataset(['Rs 4000'],layout);
output(File,Named('INPUT'));

TransformLayout:=RECORD
    String Curr;
    REAL4 formattedCurr;
  END;

TransformLayout trans(File l):=Transform
  Self.formattedCurr:=$.toCurrency(l.curr); 
  Self:=L;
 END;
  
TransformFile:=Project(File,trans(LEFT));
TransformFile;

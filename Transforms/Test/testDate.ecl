IMPORT STD, $;

Layout:=RECORD
    STRING date;
    // STRING time;
END;

// File := DATASET('~ profit::transform::eight::sample date.csv', Layout, CSV(HEADING(1)));
File :=DATASET([{'03-12-2019'},{'14-10-2015'},{'2012 02 16'},{'August 2nd 1964'},{'August 2 1964'},{'12$3-2003'}],Layout);

TransformLayout := RECORD
  STRING date;
  STRING formattedDate;
 END;
 
 TransformLayout transFunc(File l):=Transform
  SELF.formattedDate:=$.toDate(l.date);
  SELF:=l;
 END;
 
 TransformFile:=Project(File,transFunc(Left));
 TransformFile;
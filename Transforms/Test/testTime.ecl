IMPORT $;
Layout := RECORD
    // String date;
    STRING time;
END;

// File := DATASET('~ profit::transform::eight::sample date.csv', Layout, CSV(HEADING(1)));

// output(File,Named('INPUT'));

File:=Dataset([{'12:0:0'},{'23:2:52'},{'23:PM2:52'},{'PM 2:2:52'},{'13:45:30 PM'},{'3:45:30 PM'}],Layout);

TransformLayout := RECORD
    String time;
    String formattedTime;
END;

TransformLayout transFunc(File l) := Transform
    SELF.formattedTime := $.toTime(l.time);
    SELF := l;
END;

 TransformFile:=Project(File,transFunc(Left));
 TransformFile;
EXPORT CSVExtractorRecord := MODULE
  EXPORT Layout := {
    STRING order;
    STRING PID;
    DECIMAL cost;
    DECIMAL tax;
    DECIMAL total;
  };
//  EXPORT File := DATASET('~class::ssd::intro::p01-samplecsv.csv',Layout,CSV(HEADING(1)));
//  EXPORT File := DATASET(path,Layout,CSV(HEADING(1)));
END;

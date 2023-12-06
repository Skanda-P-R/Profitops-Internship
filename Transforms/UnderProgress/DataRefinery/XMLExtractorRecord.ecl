//#OPTION('obfuscateOutput',TRUE);


EXPORT XMLExtractorRecord := MODULE;
EXPORT Package:= {
  STRING tkno{XPATH('TrackingNumber')};
  STRING status{XPATH('Status')};
  STRING BoxID{XPATH('BoxId')};
};

  EXPORT Layout:= {
      STRING ono{XPATH('OrderNumber')};
      DATASET(Package) packages{XPATH('Packages/Package')};
   };
//  EXPORT File:= DATASET('~class::ssd::intro::p03-samplexml.xml',Layout,XML('Shipments/Shipment'));
END;

/*
Layout:= {
      STRING ono{XPATH('OrderNumber')};
      DATASET(Package) packages{XPATH('Packages/Package')};
   };
File:= DATASET('~class::ssd::intro::p03-samplexml.xml',Layout,XML('Shipments/Shipment'));
File;
*/
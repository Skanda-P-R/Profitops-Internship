IMPORT $;

EXPORT DataRefiner(DATASET($.JSONExtractorRecord.Layout) jsondata, DATASET($.XMLExtractorRecord.Layout) xmldata, DATASET($.CSVExtractorRecord.Layout) csvdata) := MODULE;
  costs_record := RECORD
    STRING PID;
    DECIMAL cost;
    DECIMAL tax;
    DECIMAL total;
  END;

  $.OutputJSONRecord.cost trimcsv($.CSVExtractorRecord.Layout le):= TRANSFORM
    SELF:=le;
  END;

  costsdata:= PROJECT(csvdata,trimcsv(LEFT));

  outputrecord_struct:= $.OutputJSONRecord.Layout; //record structure for output

  $.OutputJSONRecord.package GetPackageData($.XMLExtractorRecord.Package le):= TRANSFORM
    SELF.tkno:= le.tkno;
    SELF.status:= le.status;
    SELF.BoxID:= le.BoxID;
  END;

  $.OutputJSONRecord.Shipment ExtractDataFromXML($.XMLExtractorRecord.Layout le):= TRANSFORM
    SELF.ono:= le.ono;
    SELF.packages := PROJECT(le.packages,GetPackageData(LEFT));
  END;

  outputrecord_struct refinery($.JSONExtractorRecord.Layout le):= TRANSFORM
    SELF.shipments := PROJECT(xmldata(xmldata.ono=le.ono),ExtractDataFromXML(LEFT));
    SELF.costs:= PROJECT(csvdata(csvdata.order=le.ono),trimcsv(LEFT));
    SELF:= le;
  END;

  EXPORT outputdata := PROJECT(jsondata,refinery(LEFT));
END;
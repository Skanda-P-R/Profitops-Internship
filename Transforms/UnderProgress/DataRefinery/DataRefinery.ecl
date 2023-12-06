//#OPTION('obfuscateOutput',TRUE);

IMPORT $;

//csvdata:= $.CSVSerialCombiner(2,0,'~class::ssd::intro::p','-samplecsv.csv').File;
csvdata:= $.CSVCombiner(['~class::ssd::intro::p1-samplecsv.csv','~class::ssd::intro::p2-samplecsv.csv']).File;

//csvdata:= $.CSVCombiner(['~class::ssd::intro::p01-samplecsv.csv']).File;
jsondata := $.JSONCombiner(['~class::ssd::intro::p02-samplejson.json']).File;
xmldata:= $.XMLCombiner(['~class::ssd::intro::p03-samplexml.xml']).File;
//xmldata := $.TempXMLExtractorRecord.File;

OUTPUT(jsondata,NAMED('Source_1a'));
OUTPUT(xmldata, NAMED('Source_2a'));
OUTPUT(csvdata,NAMED('Source_3a'));

//OUTPUT(jsondata,,'output.json',JSON('Shipments',HEADING('[',']')));

//OUTPUT(jsondata.Customer(jsondata.Customer.name='Jane Doe'));
//OUTPUT(jsondata.Items);
//OUTPUT(tempxml.packages(tempxml.ono='CS001'));

outputdata := $.DataRefiner(jsondata,xmldata,csvdata).outputdata;
OUTPUT(outputdata, NAMED('Result_a'));


/*
csvdata2:= $.CSVSerialCombiner(2,'~class::ssd::intro::p','-samplecsv.csv').File;
jsondata2:= $.JSONSerialCombiner(2,0,'~class::ssd::intro::p','-samplejson.json').File;
xmldata2:= $.XMLSerialCombiner(2,0,'~class::ssd::intro::p','-samplexml.xml').File;

OUTPUT(jsondata2,NAMED('Source_1b'));
OUTPUT(xmldata2, NAMED('Source_2b'));
OUTPUT(csvdata2,NAMED('Source_3b'));

//OUTPUT(jsondata,,'output.json',JSON('Shipments',HEADING('[',']')));

//OUTPUT(jsondata.Customer(jsondata.Customer.name='Jane Doe'));
//OUTPUT(jsondata.Items);
//OUTPUT(tempxml.packages(tempxml.ono='CS001'));

outputdata2 := $.DataRefiner(jsondata2,xmldata2,csvdata2).outputdata;
OUTPUT(outputdata2, NAMED('Result_b'));
*/
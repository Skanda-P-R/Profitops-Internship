#MongoDB plugin-

Installation on local HPCC Cluster-





changestreams.ecl file-













display.ecl file-

This display.ecl file connects to the MongoDB cluster , a RECORD structure has been created for a specific data schema , which is then sprayed onto the HPCC Cluster through the OUTPUT where the scope of Logical File has been mentioned .
OVERWRITE helps to spray the latest versions of documents from the HistoryVersion Collection in MongoDB database.
The HistoryVersion Collection contains the JSON documents with additional fields whenever new modifications has occured in the MyCollection Collection , where the change streams is watching for changes like insertion, deletion and updation.

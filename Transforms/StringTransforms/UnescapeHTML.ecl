IMPORT Std.Str;

myString := '&lt;p&gt;This is an example paragraph with &lt;strong&gt;strong&lt;/strong&gt; and &lt;em&gt;emphasized&lt;/em&gt; text.&lt;/p&gt;';

decodedString := XMLDECODE(myString); 

myString;
decodedString;
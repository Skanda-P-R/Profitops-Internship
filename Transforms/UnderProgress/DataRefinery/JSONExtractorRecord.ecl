Customer:= {
  STRING name{XPATH('Name')};
  STRING address{XPATH('Address')};
  STRING phone{XPATH('Phone')};
};  
 
Items:={
  STRING ItemName{XPATH('ItemName')};
  INTEGER quantity{XPATH('Quantity')};
  DECIMAL price{XPATH('Price')}; 
};

EXPORT JSONExtractorRecord := MODULE;
  EXPORT Layout:= {
      STRING ono{XPATH('OrderNumber')};
      STRING date{XPATH('OrderDate')};
      STRING st{XPATH('Status')};
      DATASET(Customer) customer{XPATH('Customer')};
      DATASET(Items) items{XPATH('Items')};
   };
//  EXPORT File:= DATASET('~class::ssd::intro::p02-samplejson.json',Layout,JSON('/'));
END;



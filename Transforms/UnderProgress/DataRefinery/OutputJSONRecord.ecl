EXPORT OutputJSONRecord := MODULE;
  EXPORT Customer:= {
    STRING name{XPATH('Name')};
    STRING address{XPATH('Address')};
    STRING phone{XPATH('Phone')};
  };  
 
  EXPORT Items:={
    STRING ItemName{XPATH('ItemName')};
    INTEGER quantity{XPATH('Quantity')};
    DECIMAL price{XPATH('Price')}; 
  };

  EXPORT DATASET package:= {
  STRING tkno{XPATH('TrackingNumber')};
  STRING status{XPATH('Status')};
  STRING BoxID{XPATH('BoxId')};
};

EXPORT Shipment := {
  STRING ono{XPATH('OrderNumber')};
  DATASET(package) packages{XPATH('Packages')};
};

EXPORT cost:= {
  STRING PID;
  DECIMAL cost;
  DECIMAL tax;
  DECIMAL total;
};

  EXPORT Layout:= {
      STRING ono{XPATH('OrderNumber')};
      STRING date{XPATH('OrderDate')};
      STRING st{XPATH('Status')};
      DATASET(Customer) customer{XPATH('Customer')};
      DATASET(Items) items{XPATH('Items')};
      DATASET(Shipment) shipments{XPATH('Shipments')};
      DATASET(cost) costs{XPATH('ShippingCosts')};
   };
END;





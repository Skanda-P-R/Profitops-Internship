orderLine := RECORD//second nested child
STRING product{XPATH('product')};
STRING quantity{XPATH('quantity')};
END;

orderline_rec := RECORD//nested child
DATASET(orderLine) orderLine{XPATH('orderLine')};
END;

rform := RECORD//parent record structure
 INTEGER orderID{XPATH('orderID')};
 DATASET(orderline_rec) order_Lines{XPATH('orderLines')}  ;

END;




ds_1 := DATASET('original.json ',rform, JSON('orders/order'));//original file
ds_2 := DATASET('modification.xml', rform,XML('orders/order'));//modified file with changes

OUTPUT(ds_1, NAMED('ORIGINAL'));
OUTPUT(ds_2, NAMED('MODIFIED'));



orderline_rec m(orderline_rec l, orderline_rec  r) := TRANSFORM//first  transform
SELF.orderLine := JOIN(l.orderLine, r.orderLine, LEFT.product = RIGHT.product AND LEFT.quantity = RIGHT.quantity, RIGHT ONLY);
END;

//APPLYING ANOTHER TRANSFORM
set_ds := [ds_1, ds_2];
rform t(rform l, rform r) := TRANSFORM//second transform
SELF.order_Lines := JOIN(l.order_Lines, r.order_Lines,LEFT.orderLine <> RIGHT.orderLine, m(LEFT,RIGHT), ALL) ;
SELF := L;
END;

d := JOIN(ds_1, ds_2, LEFT.OrderID = RIGHT.OrderID, t(LEFT, RIGHT));//join for child record

d1 := JOIN(ds_2, d,LEFT.OrderID = RIGHT.OrderID, FULL ONLY); //join for parent record

d2 := JOIN(d, d1,LEFT.OrderID = RIGHT.OrderID, FULL OUTER); //complete join including both the changes above
OUTPUT(d2, NAMED('FINAL_PUSHED_DATA'));
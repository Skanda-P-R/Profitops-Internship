child_rec := RECORD
STRING genre {XPATH('genre')};
STRING year {XPATH('published_year')};
STRING publisher {XPATH('publisher')};
END;

parent_rec := RECORD
STRING ID {XPATH('id')};
STRING NAME {XPATH('name')};
STRING AUTHOR {XPATH('author')};
DATASET(child_rec) details {XPATH('details')};
END;


ds_1 := DATASET('old::old.json',parent_rec,JSON('/'));
ds_2 := DATASET('latest::latest.json',parent_rec,JSON('/'));
OUTPUT(ds_1, NAMED('ORIGINAL'));
OUTPUT(ds_2, NAMED('MODIFIED'));



set_ds := [ds_1, ds_2];
parent_rec t(parent_rec l, parent_rec r) := TRANSFORM
SELF.details := JOIN(l.details, r.details ,LEFT.year = RIGHT.year, RIGHT ONLY) ;
SELF := L;
END;
child_join:= JOIN(ds_1, ds_2, LEFT.ID = RIGHT.ID AND LEFT.details <> RIGHT.details, t(LEFT, RIGHT));//for the child dataset

parent_join := JOIN(ds_1, ds_2, LEFT.NAME = RIGHT.NAME AND LEFT.AUTHOR = RIGHT.AUTHOR, RIGHT ONLY);//for the parent dataset


net_modified_rows := JOIN(y, x, LEFT.ID = RIGHT.ID, FULL OUTER);//the final join which includes the modified records
OUTPUT(net_modified_rows);
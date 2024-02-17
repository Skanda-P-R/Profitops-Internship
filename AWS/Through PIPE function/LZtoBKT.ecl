rec := RECORD
    STRING message;
END;

//add credentials
// STRING access_key :='';
// STRING secret_key :='';
// STRING default_region :='us-east-1';
STRING bkt_name := 'fromlogical';
STRING folder_in_lz_to_sync := 'bkt_desprayed';
// PIPE('aws configure set aws_access_key_id ' + access_key, rec, csv);
// PIPE('aws configure set aws_secret_access_key ' + secret_key, rec, csv);
// PIPE('aws configure set default_region ' + default_region,  rec, csv);
// PIPE('aws configure set output json ', rec, csv);
PIPE('aws s3 sync /var/lib/HPCCSystems/mydropzone/'+folder_in_lz_to_sync+' s3://'+bkt_name+'/', rec, csv) : WHEN(CRON('* * * * *'));

rec := RECORD
    STRING message;
END;

//add AWS S3 credentials
STRING access_key :='';
STRING secret_key :='';
STRING default_region :='';
STRING output_format:='';
STRING bkt_name := '';
STRING folder_in_bkt_to_sync := '';
PIPE('aws configure set aws_access_key_id ' + access_key, rec, csv);
PIPE('aws configure set aws_secret_access_key ' + secret_key, rec, csv);
PIPE('aws configure set default_region ' + default_region,  rec, csv);
PIPE('aws configure set output json ' + output_format, rec, csv);
PIPE('aws s3 sync s3://'+bkt_name+'/'+folder_in_bkt_to_sync+' /var/lib/HPCCSystems/mydropzone/CSV --delete', rec, csv) : WHEN(CRON('* * * * *'));
//the sync command is made CRON, which executes the sync every 60 seconds
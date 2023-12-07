#!/bin/bash


s3_bucket="awsbkt870"


initial_files=($(aws s3 ls s3://$s3_bucket | awk '{print $NF}'))

check_changes() {
    current_files=($(aws s3 ls s3://$s3_bucket | awk '{print $NF}'))
    
    
    removed_files=()

    
    for file in "${initial_files[@]}"; do
        if [[ ! " ${current_files[@]} " =~ " $file " ]]; then
            removed_files+=("$file")
        fi
    done

    initial_files=("${current_files[@]}")
    for file_name in "${removed_files[@]}"; do
    	dfuplus action=despray server=http://localhost:8010/ dstip=10.0.2.15  dstfile=/home/prashant/Downloads/Desprayed_Files/$file_name  srcname=hthor::pr::$file_name overwrite=1

    	echo "deleted ${file_name}"
    done
}
while true; do
    check_changes
    sleep 6
done 


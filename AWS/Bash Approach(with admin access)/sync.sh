#!/bin/bash


s3_bucket="versions870"


local_directory="/var/lib/HPCCSystems/mydropzone"

aws s3 sync s3://$s3_bucket $local_directory --delete


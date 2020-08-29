#!/bin/bash

for f in `aws s3api list-buckets --profile PUA|grep Name|grep -v DisplayName|sed 's/"//g;s/://g;s/,//g'|awk '{ print $2 }'`
do
   echo ""
   echo "Nome do bucket: $f"
   aws s3api get-bucket-policy-status --bucket $f --profile PUA
   echo "=-----=-----=-----=-----="
done

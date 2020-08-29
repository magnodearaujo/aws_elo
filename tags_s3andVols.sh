#!/bin/bash

# S3
for i in $(aws s3api list-buckets --query "Buckets[].Name" --profile PUA|sed 's/"//g; s/,//g'|egrep -v '\[|\]')
do

   aws s3api put-bucket-tagging --bucket $i --tagging 'TagSet=[{Key=Environment,Value=PRD},{Key=Epic,Value=All},{Key=SquadOwner,Value=TechTeam},{Key=CostCenter,Value=Shared},{Key=Createdby,Value=Console},{Key=IAMBlock,Value=Yes}]' --profile=PUA
done

# Volumes
for i in $(aws ec2 describe-volumes --region sa-east-1 --profile=PUA|grep VolumeId|grep -v "                    "|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

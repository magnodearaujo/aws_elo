#!/bin/bash


for i in $(aws ec2 describe-subnets --profile PUA --region sa-east-1|grep SubnetId|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region sa-east-1 --dry-run --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

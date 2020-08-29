#!/bin/bash

# ENI
for i in $(aws ec2 describe-network-interfaces --profile PUA  --region sa-east-1|grep NetworkInterfaceId|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

# EC2
for i in $(aws ec2 describe-instances --profile PUA  --region sa-east-1|grep InstanceId|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes Key=SecurityPatch,Value=MediumLinux --profile=PUA
done

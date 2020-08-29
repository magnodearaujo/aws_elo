#!/bin/bash

# EIP
for i in eipalloc-00ad13d30bfd01c7a eipalloc-0b5dfafcb82a9ced5 eipalloc-019aa60a03cbb8d0d eipalloc-093625cd5de4e8674
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

# Endpoint
for i in vpce-0419ee1c59d924614 vpce-0a9321332803a0a5c
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

# DHCP Options
for i in dopt-b6079ad1
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

# NACL
for i in $(aws ec2 describe-network-acls --profile PUA  --region sa-east-1|grep NetworkAclId|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region sa-east-1 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

# SG
for i in $(aws ec2 describe-security-groups --profile PUA  --region us-east-2|grep GroupId|awk '{ print $2 }'|sed 's/"//g; s/,//g')
do
   aws ec2 create-tags --region us-east-2 --resources $i --tags Key=Environment,Value=PRD Key=Epic,Value=All Key=SquadOwner,Value=TechTeam Key=CostCenter,Value=Shared Key=Createdby,Value=Console Key=IAMBlock,Value=Yes --profile=PUA
done

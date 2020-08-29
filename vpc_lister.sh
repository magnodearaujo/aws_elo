#/usr/bin/env bash

export REGIONS=$(aws ec2 describe-regions --profile PUA| jq -r ".Regions[].RegionName")
#export REGIONS=$(aws ec2 describe-regions --profile PUA|grep RegionName|awk '{ print $2 }'|sed 's/"//g;s/,//'|grep $1)

for region in $REGIONS; do
    # list vpcs
    echo $region
    aws --region=$region ec2 describe-vpcs  --profile PUA| jq ".Vpcs[]|{is_default: .IsDefault, cidr: .CidrBlock, id: .VpcId} | select(.is_default)"
done

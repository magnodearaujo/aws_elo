#/usr/bin/env bash

#export REGIONS=$(aws ec2 describe-regions --profile PUA| jq -r ".Regions[].RegionName")
export REGIONS=$(aws ec2 describe-regions --profile PUA|grep RegionName|awk '{ print $2 }'|sed 's/"//g;s/,//'|grep $1)

for region in $REGIONS; do
    # list Cloud Front
    echo $region
    aws --region=$region cloudfront list-distributions --profile PUA|grep -e "Id" -e "ARN" -e "Domain"
    # list ELBs
    echo $region
    aws --region=$region elb describe-load-balancers --load-balancer-names --profile PUA|grep -e "LoadBalancerName" -e "CanonicalHostedZoneName"
done

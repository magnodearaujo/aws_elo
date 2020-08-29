#/usr/bin/env bash

export REGIONS=$(aws ec2 describe-regions --profile PUA|grep RegionName|awk '{ print $2 }'|sed 's/"//g;s/,//'|grep $1)

for region in $REGIONS; do
    # list vpcs
    echo $region
    aws --region=$region ec2 describe-vpcs --profile PUA| jq ".Vpcs[]|{is_default: .IsDefault, cidr: .CidrBlock, id: .VpcId} | select(.is_default)"
done

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    for region in $REGIONS ; do
        echo "Killing $region"
        # list vpcs
        export IDs=$(aws --region=$region ec2 describe-vpcs --profile PUA| jq -r ".Vpcs[]|{is_default: .IsDefault, id: .VpcId} | select(.is_default) | .id")
        for id in "$IDs" ; do
            if [ -z "$id" ] ; then
                continue
            fi

            # kill igws
            for igw in `aws --region=$region ec2 describe-internet-gateways --profile PUA| jq -r ".InternetGateways[] | {id: .InternetGatewayId, vpc: .Attachments[0].VpcId} | select(.vpc == \"$id\") | .id"` ; do
                echo "Killing igw $region $id $igw"
                aws --region=$region ec2 detach-internet-gateway --internet-gateway-id=$igw --vpc-id=$id --profile PUA
                aws --region=$region ec2 delete-internet-gateway --internet-gateway-id=$igw --profile PUA
            done

            # kill subnets
            for sub in `aws --region=$region ec2 describe-subnets --profile PUA| jq -r ".Subnets[] | {id: .SubnetId, vpc: .VpcId} | select(.vpc == \"$id\") | .id"` ; do
                echo "Killing subnet $region $id $sub"
                aws --region=$region ec2 delete-subnet --subnet-id=$sub --profile PUA
            done

            echo "Killing vpc $region $id"
            aws --region=$region ec2 delete-vpc --vpc-id=$id --profile PUA
        done
    done

fi


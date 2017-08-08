#!/bin/bash



aws autoscaling create-launch-configuration --launch-configuration-name awsadp --image-id ami-835b4efa --key-name 'enter Keyname' --security-groups 'enter security group' --instance-type t2.micro  --iam-instance-profile developer --user-data file://dockerinstall.sh

sleep 50


#Create a load balancer aws elb create load-balancer
aws elb create-load-balancer --load-balancer-name performance360 --listeners Protocol=Http,LoadBalancerPort=80,InstanceProtocol=Http,InstancePort=80 --security-groups 'security group name' --availability-zones us-west-2b
echo "load balancer created"

aws autoscaling create-auto-scaling-group --auto-scaling-group-name webserverdemo1 --launch-configuration awsadp --availability-zone us-west-2b --load-balancer performance360 --max-size 6 --min-size 1 --desired-capacity 2


sleep 100

ID=`aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[].InstanceId'`


aws elb create-lb-cookie-stickiness-policy --load-balancer-name performance360 --policy-name amachirapolicy

echo "load balancer policy created"

aws elb set-load-balancer-policies-of-listener --load-balancer-name performance360 --load-balancer-port 80 --policy-names amachirapolicy

#sleep 50
echo "load balancer listener created"


#Register instances aws elb register instances with load balancer

aws elb register-instances-with-load-balancer --load-balancer-name performance360 --instances $ID
#sleep 50
echo "instances are registered"


echo "auto scaling group created max-size 6, min-size 2, desired capacity 2"




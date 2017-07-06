#!/bin/bash


#aws ec2 run-instances --image-id ami-835b4efa --key-name anagh-adp --security-group-ids sg-d3659ba9 --instance-type t2.micro --count 1  --placement AvailabilityZone=us-west-2b

aws autoscaling create-launch-configuration --launch-configuration-name awsadp --image-id ami-835b4efa --key-name anagh-adp --security-groups sg-d3659ba9 --instance-type t2.micro  --iam-instance-profile developer --user-data file://installapp.sh

#Create a load balancer aws elb create load-balancer
aws elb create-load-balancer --load-balancer-name itmo-544-amachira --listeners Protocol=Http,LoadBalancerPort=80,InstanceProtocol=Http,InstancePort=80 --subnets subnet-42b29126
echo "load balancer created"

aws elb create-lb-cookie-stickiness-policy --load-balancer-name itmo-544-amachira --policy-name amachirapolicy

echo "load balancer policy created"

aws elb set-load-balancer-policies-of-listener --load-balancer-name itmo-544-amachira --load-balancer-port 80 --policy-names amachirapolicy

echo "load balancer listener created"

ID1=`aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[].InstanceId'`

#Register instances aws elb register instances with load balancer

echo $ID1
aws elb register-instances-with-load-balancer --load-balancer-name itmo-544-amachira --instances $ID1
echo "instances are registered"

#aws autoscaling create-launch-configuration --launch-configuration-name awsadp --image-id ami-835b4efa --key-name anagh-adp --security-groups sg-d3659ba9 --instance-type t2.micro  --iam-instance-profile developer

#Create and attach aws autoscaling autoscaling group - set min, max, and desired capacity - attaching launch conf and load-balancer
aws autoscaling create-auto-scaling-group --auto-scaling-group-name webserverdemo1 --launch-configuration awsadp --availability-zone us-west-2b  --load-balancer itmo-544-amachira --max-size 6 --min-size 1 --desired-capacity 2


echo "auto scaling group created max-size 6, min-size 2, desired capacity 2"




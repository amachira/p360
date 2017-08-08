#!/bin/bash
ID=`aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[].InstanceId'`

echo $ID

#aws autoscaling describe-auto-scaling-instances --instance-ids $ID

echo autoscaling-instances----------------------

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name webserverdemo1 --force-delete
echo "Auto Scaling Group deleted"

aws autoscaling delete-launch-configuration --launch-configuration-name awsadp
echo "Launch Configuration deleted"

#aws ec2 terminate-instances --instance-ids $ID
echo "delete instances"

#aws elb de register instances from load-balancer
aws elb deregister-instances-from-load-balancer --load-balancer-name performance360 --instances $ID

echo "De register instances from the load balancer"

#aws elb delete listeners
aws elb delete-load-balancer-listeners --load-balancer-name performance360 --load-balancer-ports 80

echo "Delete load balancer listeners"

#aws elb delete load-balancers
 aws elb delete-load-balancer --load-balancer-name performance360

echo "Load Balacer Deleted"

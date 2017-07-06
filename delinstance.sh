#!/bin/bash
ID=`aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[].InstanceId'`

echo $ID
lbname=`aws elb describe-load-balancers | awk {' print $6'}`
IFS=' ' read -ra lb <<< "$lbname"
#echo ${lb[0]}

asgrp=` aws autoscaling  describe-auto-scaling-groups | awk {' print $3'}`
IFS=' ' read -ra asg <<< "$asgrp"
#echo ${asg[0]}

aslg=` aws autoscaling describe-launch-configurations | awk {' print $10'}`

#aws autoscaling detach load-balancers from autoscaling group
#aws autoscaling detach-load-balancers --load-balancer-names ${lb[0]}   --auto-scaling-group-name ${asg[0]}

#aws autoscaling detach instances
#aws autoscaling detach-instances  --instance-ids $ID --auto-scaling-group-name ${asg[0]} --no-should-decrement-desired-capacity

aws autoscaling describe-auto-scaling-instances --instance-ids $ID

echo autoscaling-instances----------------------
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${asg[0]}

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name ${asg[0]} --force-delete

aws ec2 terminate-instances --instance-ids $ID
#aws autoscaling delete-launch configuration
aws autoscaling delete-launch-configuration --launch-configuration-name $aslg

#aws elb de register instances from load-balancer
aws elb deregister-instances-from-load-balancer --load-balancer-name ${lb[0]} --instances $ID

#aws elb delete listeners
aws elb delete-load-balancer-listeners --load-balancer-name ${lb[0]} --load-balancer-ports 80

#aws elb delete load-balancers
aws elb delete-load-balancer --load-balancer-name ${lb[0]}


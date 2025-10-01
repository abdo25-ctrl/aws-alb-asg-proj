# Create ALB
aws elbv2 create-load-balancer \
  --name webapp-alb \
  --subnets subnet-1a subnet-1b \
  --security-groups sg-alb

# Create Target Group
aws elbv2 create-target-group \
  --name webapp-tg \
  --protocol HTTP \
  --port 80 \
  --vpc-id vpc-123456

# Create Listener
aws elbv2 create-listener \
  --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/webapp-alb/50dc6c495c0c9188 \
  --protocol HTTP \
  --port 80 \
  --default-actions Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/webapp-tg/1234567890123456
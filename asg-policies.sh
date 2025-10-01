aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name webapp-asg \
  --launch-template LaunchTemplateName=webapp-lt,Version='$Latest' \
  --min-size 2 \
  --max-size 6 \
  --desired-capacity 2 \
  --vpc-zone-identifier "subnet-1a,subnet-1b" \
  --target-group-arns arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/webapp-tg/1234567890123456 \
  --health-check-type ELB \
  --health-check-grace-period 300
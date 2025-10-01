# Create SNS Topic
aws sns create-topic --name app-alerts

# CPU Utilization Alarm
aws cloudwatch put-metric-alarm \
  --alarm-name High-CPU-WebApp \
  --alarm-description "High CPU Utilization" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 75 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2 \
  --alarm-actions arn:aws:sns:us-east-1:123456789012:app-alerts \
  --dimensions "Name=AutoScalingGroupName,Value=webapp-asg"
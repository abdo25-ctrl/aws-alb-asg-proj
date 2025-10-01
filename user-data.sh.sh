#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Custom homepage
echo "<html>
<head><title>Scalable WebApp</title></head>
<body>
  <h1>Hello from $(hostname -f)</h1>
  <p>Deployed via Auto Scaling</p>
</body></html>" > /var/www/html/index.html
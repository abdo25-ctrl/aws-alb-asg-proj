# 🚀 Scalable Web Application on AWS (ALB + Auto Scaling)

## 📌 Project Overview
Deploy a simple, scalable, and highly available web application on AWS using:
- EC2 (web servers)
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Amazon RDS for the database
- CloudWatch + SNS for monitoring

This project is done **manually from AWS Console (no Terraform)** to practice AWS fundamentals.

---

## 🛠 Architecture

Key Components & Data Flow:
    1- Internet Users: Access via ALB DNS name 
    2- Application Load Balancer (ALB):
               -  Distributes traffic across AZs
               -  Health checks on instances (HTTP:80/)
               -  Security Group: Allows HTTP(80) from 0.0.0.0/0

   3- Auto Scaling Group (ASG):
          - Min: 2, Desired: 2, Max: 4 instances
          - Uses Launch Template with:
             - Amazon Linux 2 AMI
             - t3.micro instances
             - User Data bootstrap script
          - Multi-AZ deployment (spreads instances across availability zones)
    4- EC2 Instances:
            - Run web server via User Data script
            - Security Group: Allows HTTP(80) only from ALB SG, SSH(22) from trusted IP
            - Automatically register with ALB Target Group
    5- Monitoring & Alerts:
            - CloudWatch tracks:
               - ASG Instance Count
               - EC2 CPU/Memory
               - ALB Request Count/4xx/5xx Errors
            - SNS sends alerts for:
               - High CPU (>75%)
               - Failed Health Checks
               - Scaling Events


Architecture Diagram

https://i.postimg.cc/SRCDb2Rd/1-8-Fwhw-NQc7977-FCg-W7-TLwo-Q.webp
 ![image alt]([image_url](https://i.postimg.cc/SRCDb2Rd/1-8-Fwhw-NQc7977-FCg-W7-TLwo-Q.webp
)) 

![Image](https://github.com/user-attachments/assets/aa184ebe-f10b-4282-b0d8-a140c9f3e064)

_____________________________________________________________
## Launch EC2 & Create VPC & Networking

- Create a new VPC (e.g., `10.0.0.0/16`).
- Create **2 public subnets** in different AZs.
- Create **Internet Gateway** and attach to VPC.
- Add **Route Table** to allow internet access.
- Launch EC2

<img width="1680" height="862" alt="Image" src="https://github.com/user-attachments/assets/33d26508-7fb2-44a4-9e3a-c9aa26aeae3d" />

<img width="1680" height="897" alt="Image" src="https://github.com/user-attachments/assets/540e868b-d1bd-42e0-bd2e-ad11e5b8ce3a" />

<img width="1680" height="897" alt="Image" src="https://github.com/user-attachments/assets/722bf740-cd2d-4340-bba1-116467ee0d3f" />

<img width="1680" height="897" alt="Image" src="https://github.com/user-attachments/assets/f9a9d7c7-e66c-4893-b6fc-dbe7c53de290" />

<img width="874" height="192" alt="Image" src="https://github.com/user-attachments/assets/c9fd9e84-fc9f-4f5f-946e-4d477c9b9519" />

<img width="856" height="747" alt="Image" src="https://github.com/user-attachments/assets/4f8f2547-87bd-412c-9606-16602ed4b5bc" />

<img width="880" height="341" alt="Image" src="https://github.com/user-attachments/assets/96344bce-81bf-493d-96f5-4586df16a8e6" />

<img width="874" height="315" alt="Image" src="https://github.com/user-attachments/assets/48355501-0c45-4f12-ab55-c5b1d01c03a5" />

<img width="424" height="508" alt="Image" src="https://github.com/user-attachments/assets/216822e8-45ae-4590-8f4c-e2e9b26f59e1" />

<img width="1374" height="412" alt="Image" src="https://github.com/user-attachments/assets/75b1e686-2e0a-40fb-b329-0e6b74250699" />

---


Security Groups
- `web-sg`: Allow **HTTP (80)** from `0.0.0.0/0`, **SSH (22)** only from your IP.
- `alb-sg`: Allow HTTP (80) from `0.0.0.0/0`, forward to `web-sg`.
_____________________________________________________________
Auto Scaling Group

<img width="1391" height="334" alt="Image" src="https://github.com/user-attachments/assets/6b0131ea-ecff-4bec-85f4-725ac0bc48df" />

<img width="1356" height="744" alt="Image" src="https://github.com/user-attachments/assets/7f065896-afc1-4328-95c4-27317d7505a6" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/1a618ee4-1047-431f-8e48-6b98858a0b4f" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/d963e564-cd03-4ae8-b498-069d8a7fb7db" />

<img width="1620" height="719" alt="Image" src="https://github.com/user-attachments/assets/f14da0c8-4a19-494d-9b41-8d4a68d3a4cb" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/eb631e8a-e730-4bf6-a5a7-4593c3dd96d5" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/6c0f1cb3-a0bb-4974-863e-6f0771fc15fa" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/5ceae015-4813-4d14-8fda-9bdaa7f75e3f" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/323e5b54-05ca-42a1-b543-7b0ecb023365" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/0ac149d4-1f5d-4d9a-b00f-8a31716abc87" />

<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/20e6ab09-0138-456a-a847-81e0ad71f65c" />

---

Launch Template
- AMI: **Amazon Linux 2023**  
- Instance type: `t2.micro`  
- User data script:


_____________________________________________________________

Application Load Balancer

Console path: EC2 → Load Balancers → Create load balancer → Application Load Balancer

Name: proj1-alb

Scheme: Internet-facing

IP address type: IPv4

VPC: proj1-vpc

Mappings (Subnets): 2 Public subnets in 2 AZs 

Security groups: proj1-alb-sg

Listeners and routing:

Listener: HTTP : 80 → Default action: Forward to proj1-tg

<img width="1391" height="334" alt="Image" src="https://github.com/user-attachments/assets/94b81796-28a2-4577-991f-8a0c0a6b8f7b" />
<img width="1615" height="715" alt="Image" src="https://github.com/user-attachments/assets/79ba1caa-fddf-4131-984e-e781776a7944" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/a747977f-1cef-4767-8395-94760fa3f789" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/bde5e07e-a2a7-4a8e-8ebf-39a31852dbed" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/c9827978-bc0b-4026-b379-99940cccc481" />

_____________________________________________________________
Auto Scaling Group

Console path: EC2 → Auto Scaling Groups → Create Auto Scaling group

Name: proj1-asg

Launch template: proj1-ec2-lt

VPC: proj1-vpc

Subnets: 2 Public subnets 

Load balancing:

Attach to an existing load balancer → Application Load Balancer proj1-alb

Target groups: proj1-tg

Health checks: Enable ELB health checks → Health check grace period: 60 sec

Group size:

Desired capacity: 2

Minimum capacity: 2

Maximum capacity: 4

Scaling policies:

Choose Target tracking scaling policy

Metric type: Average CPU utilization

Target value: 50%

Instance warmup: 180 sec

Monitoring: Enable CloudWatch group metrics collection

<img width="1391" height="334" alt="Image" src="https://github.com/user-attachments/assets/5f91ee79-eccc-4630-898e-9101068c1405" />
<img width="1356" height="744" alt="Image" src="https://github.com/user-attachments/assets/394d9010-7386-47c8-bfc7-7afe80845e0c" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/f4a7bf09-3d7c-48ab-afd3-c8226cc14b81" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/e4473628-9ba1-4b9a-8da0-ae3217b27c7b" />
<img width="1620" height="719" alt="Image" src="https://github.com/user-attachments/assets/e2b129c9-78c9-4572-82e3-846c7b52b3f4" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/fb8d2bd1-ed93-46f5-a62f-cab5d9400d03" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/e14bee33-9fdc-44e6-b990-62a24f3e4bde" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/576b97c6-1992-45d6-9a67-fe4f36af54db" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/14bc1820-a5c7-422e-9848-312c1f605fb8" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/efc61baf-1500-4a10-bd4e-db1192eb7af5" />
<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/4da7ec3a-8dbb-4225-a5f3-e5b07d42916f" />

_____________________________________________________________

RDS


h<img width="1680" height="771" alt="Image" src="https://github.com/user-attachments/assets/3788ee62-c1e8-4ed5-a529-9f896adccae2" />
<img width="1680" height="897" alt="Image" src="https://github.com/user-attachments/assets/097f0d29-bec0-49c1-bfeb-1d5680a1d190" />
<img width="1636" height="421" alt="Image" src="https://github.com/user-attachments/assets/bad3df00-9aab-4a6f-b5a3-fda77ba4775b" />
<img width="1574" height="645" alt="Image" src="https://github.com/user-attachments/assets/7108fb39-7f40-4f2f-a07c-8f68beb8b459" />
<img width="1300" height="663" alt="Image" src="https://github.com/user-attachments/assets/431d3b7b-db32-4f4f-a821-19deedc6612b" />
<img width="1300" height="719" alt="Image" src="https://github.com/user-attachments/assets/46d2caa8-0c0e-41d0-af38-59b5da775a54" />
<img width="1584" height="783" alt="Image" src="https://github.com/user-attachments/assets/e032e5da-d05a-462c-8e6c-2e66b7b3f2c2" />
<img width="1562" height="617" alt="Image" src="https://github.com/user-attachments/assets/26801803-787c-4723-9645-b9207c43ef12" />
<img width="1122" height="330" alt="Image" src="https://github.com/user-attachments/assets/23f49b03-f45d-4d3c-b255-39f0f3c12930" />
<img width="1562" height="515" alt="Image" src="https://github.com/user-attachments/assets/8aab7db9-428a-40c5-834f-6fe719102391" />



_____________________________________________________________

CloudWatch + SNS 

<img width="1663" height="412" alt="Image" src="https://github.com/user-attachments/assets/a45945c1-c4a4-4091-bfc6-513826b70bec" />
<img width="1613" height="585" alt="Image" src="https://github.com/user-attachments/assets/62d2c507-2385-413c-8506-8307ff17cd64" />
<img width="1424" height="766" alt="Image" src="https://github.com/user-attachments/assets/479292a3-4cea-4a4d-8f31-9c6b0b5d8957" />
<img width="1632" height="714" alt="Image" src="https://github.com/user-attachments/assets/167ce2ab-3f93-4910-a305-446db950d0e9" />
<img width="1680" height="897" alt="Image" src="https://github.com/user-attachments/assets/fbb44085-083e-457c-af9b-40553bd4ff81" />
<img width="1680" height="766" alt="Image" src="https://github.com/user-attachments/assets/2840e20a-948d-4bd2-8a65-ec057c5a8ddb" />
<img width="1680" height="766" alt="Image" src="https://github.com/user-attachments/assets/c4ffccd1-478b-42c7-9ae7-d9cd7aad0199" />
<img width="1680" height="766" alt="Image" src="https://github.com/user-attachments/assets/2d2e9890-0d56-4c91-bbb3-ddb89f3845d5" />
<img width="1663" height="853" alt="Image" src="https://github.com/user-attachments/assets/f34ffa0f-4ea7-4980-a454-573c30668bc6" />

```
bash
#!/bin/bash
yum update -y
amazon-linux-extras enable nginx1
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>Hello from $(hostname)</h1>" > /usr/share/nginx/html/index.html

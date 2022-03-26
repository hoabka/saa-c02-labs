## Create an auto scale system

![Auto scalling](https://miro.medium.com/max/974/1*uS9J8btKCQaMOhnUXp62aA.jpeg)

**Create an Application Load Balancer**
1.  Navigate to EC2 > Load Balancers.

2.  Click Create Load Balancer.

3.  Click the Create button under the Application Load Balancer and set the following values:

    -   *Name*: HOLALB
    -   *Scheme*: internet-facing
    -   *IP address type*: ipv4
    -   *Load Balancer Protocol*: HTTP
    -   *Port*: 80
    -   Select the VPC.
    -   Add subnets to the Load Balancer
4.  Click Next: Configure Security Settings

    > Note: Skip this screen, as we are not using HTTPS.

5.  Click Next: Configure Security Groups.

6.  Select to Create a new security group for your ALB, and set the following values:

    -   *Name*: ALBSG
    -   *Description*: ALBSG
    -   The default value allows standard HTTP traffic from 0.0.0.0/0 and ::/0 (IPV6), so leave as it.
7.  Click Next: Configure Routing and enter the following values:

    -   *Name*: ALBTG
    -   *Target type*: Instance
    -   *Protocol*: HTTP
    -   *Port*: 80
8.  Expand Advanced health check settings, and reduce the healthy and unhealthy threshold checks down to 2.

    -   This means the load balancer can respond faster and instances come into service and vice versa.
9.  Click Next: Register Targets.

10. Click Next: Review.

Make a note of the DNS name associated with the load balancer and open in a new browser tab. You should see a 503 error since we don't have any operational EC2 instances associated with the load balancer.

**Create a Launch Template**

Create an SSH key pair that the EC2 instances will use to control access. We will use the key pair to connect to the EC2 instances in order to perform load testing:

1.  Navigate to EC2 > Network & Security > Key Pairs.
2.  Click Create Key Pair.
3.  Call it ALBKP, and download the file to your local machine.

Create a security group for EC2 instances. This security group will allow us to SSH into the instances and it will allow the ALB to point frontend connections to the instances over port 80.

1.  Navigate to EC2 > Network & Security > Security Groups.
2.  Click Create Security Group.
3.  The name and description are EC2WEBSG.
4.  Set the VPC to the lab VPC.
5.  Add a rule allowing SSH from 0.0.0.0/0 and ::/0 (IPV6).
6.  Add a rule allowing HTTP from the Security Group ID of the security group for the ALB created in the previous video.
7.  Create the security group.

Create a launch template that will be used by the Auto Scaling group. The launch template defines what the instances are and how they are created.

1.  Navigate to EC2 > Instances > Launch Templates.

2.  Create a new template, and call it HOLLT for the name and description.

3.  Search for "AMI", and pick the Amazon Linux 2 AMI (64-bit x86).

4.  Set the instance type as t2.micro.

5.  Select the key pair you created earlier.

6.  The network type is VPC.

7.  Select the EC2WEBSG security group you created earlier.

8.  Storage should automatically be populated with a volume, so leave that as default and don't add anything to the network section.

9.  Expand *Advanced Details*, and paste the user data in the box.  

>    #!/bin/bash  
    yum update -y  
    yum install -y httpd  
    yum install -y wget  
    cd /var/www/html  
    wget https://raw.githubusercontent.com/hoabka/saa-c02-labs/master/route-53/index.html  
    service httpd start  
    sudo amazon-linux-extras install epel -y  
    sudo yum install -y stress  
    stress --cpu 2 --timeout 300




10. Click Create Launch Template.

11. Click Close.

Create an Auto Scaling Group

Note: Make sure the load balancer is ready at this point.

1.  EC2 > Auto Scaling > Auto Scaling Groups
2.  Click Create Auto Scaling group.
3.  Call the group HOLASG.
4.  Select Launch Template, and choose the template you just created.
5.  Select Adhere to Launch Template.
6.  Pick the VPC from the lab environment, and select subnets. Normally we should use private subnet for our application, but in this case, we use public subnet because private subnet might not have connection to the internet.
7.  Click Next.
8.  Select **Attach to an existing load balancer**.
9.  Select target group ALBTG.
10. Leave the default for *Health checks*.
11. Select Enable group metrics collection with CloudWatch.
12. Select **Next**
12. For *Group Size*, enter the following values:
    -   *Desired Capacity*: 2
    -   *Minimum Capacity*: 2
    -   *Maximum Capacity*: 6
13. For *Scaling Policies*, select Target tracking scaling policy and enter the following values:
    -   *Scaling Policy Name*: Target Tracking Policy
    -   *Metric type*: Average CPU utilization
    -   *Target value*: 50
    -   *Instances need*: 300
14. Click Next.
15. Click Create Auto Scaling Group.

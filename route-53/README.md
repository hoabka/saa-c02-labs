# Creating records by using the Amazon Route 53

## Step 1: Create EC2 Instances:
Create 2 EC2 instance with these requirements:
-   Use Amazon Linux 2 AMI (64-bit x86) Image
-   Have Public IP 
-   Attach a security group open for HTTP protocol
-   Userdata for Instances:
>   for the first Instance:  

    #!/bin/bash
    yum update -y
    yum install -y httpd
    yum install -y wget
    cd /var/www/html
    wget *file1*
    service httpd start

>   for the second Instance:  

    #!/bin/bash
    yum update -y
    yum install -y httpd
    yum install -y wget
    cd /var/www/html
    wget *file2*
    service httpd start


## Step 2: Switch to the practice account:
1.  Open the switch role console by go to [switch role console](https://signin.aws.amazon.com/switchrole?roleName=Route53FullAccess&account=hoabka)
2.  Click the **Switch Role** button.

## Step 3: Create simple record using the Route 53


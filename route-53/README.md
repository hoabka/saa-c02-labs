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
    wget https://raw.githubusercontent.com/hoabka/saa-c02-labs/master/route-53/index.html
    service httpd start

>   for the second Instance:  

    #!/bin/bash
    yum update -y
    yum install -y httpd
    yum install -y wget
    cd /var/www/html
    wget https://raw.githubusercontent.com/hoabka/saa-c02-labs/master/ha-architecture/index.html
    service httpd start


## Step 2: Switch to the practice account:
1.  Open the switch role console by go to [switch role console](https://signin.aws.amazon.com/switchrole?roleName=Route53FullAccess&account=hoabka)
2.  Click the **Switch Role** button.

## Step 3: Create simple record using the Route 53

1.  Sign in to the AWS Management Console and open the Route 53 console at <https://console.aws.amazon.com/route53/>.

2.  In the navigation pane, choose Hosted zones.

3.  On the Hosted zones page, choose the name of the hosted zone `cloudnut.vn`
4.  Choose Create record.
5.  In the record setting page, specify the following values:  
-   **Record name**: Enter the name of the domain or subdomain that you want to route traffic for.
-   **Record type**: Select **A — IPv4 address**
-   **Value**: Ip of the first EC2 was created before
-   **TTL (seconds)**: Choose 1m
-   **Routing policy**: Select **Simple routing**

6. Wait some minites, then copy and paste the domain to web browser.

# Step3: Creating Amazon Route 53 health checks and configuring DNS failover

## Creating Route53 health check
1.  Sign in to the AWS Management Console and open the Route 53 console at <https://console.aws.amazon.com/route53/>.

2.  In the navigation pane, choose Health Checks.

3.  Choose Create Health Check. 

4.  In the create health check console, specify the following values:  
-   **Name**: An unique name
-   **What to monitor**: Endpoint
-   **Specify endpoint by**: IP
-   **Protocol**: HTTP
-   **IP address**: The first EC2's IP
-   **Port**: 80
5. Click Next

6.  Choose Create Health Check.

## Creating failover DNS

1. Go to Route 53 console > Hosted zones > `cloudnut.vn`.
2. Choose the domain, click to **Edit record**
3. Change Routing policy to failover
4. Change Failover record type to Primary
5. In the Health check option, choose the health check was created before.
6. Enter an unique id for Record ID
7. Click Save.

Create an addition domain with these values:
-   **Record name**: Same the first domain
-   **Record type**: Select **A — IPv4 address**
-   **Value**: Ip of the second EC2 was created before
-   **TTL (seconds)**: Choose 1m
-   **Routing policy**: Select **Failover**
-   **Failover record type**: Secondary
-   **Record ID**: An unique ID

## Test DNS failover
1. Paste the domain to web browser, you will see the content in the first EC2

2. Stop the first EC2

3. Wait some minutes until the health check stauts  change to un-healthy
4. Access to the domain again, now you should see the content in the second EC2.


# Delele records and health check
1. Choose Hosted zones > `cloudnut.vn`
2. Choose domains created before
3. Click delete records
4. Click Delete

5. Choose Health checks 
6. Select the health check created before
7. Click Delete health check.
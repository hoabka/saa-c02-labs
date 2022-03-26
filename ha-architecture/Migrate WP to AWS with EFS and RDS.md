# Overview

Highly Available and Fault Tolerant Solution

![](https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/cover.png)

# Lab Details
 
1. This lab walks you through the step by step procedure on how to migrate an existing Wordpress site to an AWS with High Availibility and Scalibility.

2. Duration: **1 Hour 30 minutes**

3. AWS Region: **N. Virginia (us-east-1)**

# Architecture Diagram

![](https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/architecture.png)

# AWS Service


1.  Relational Database Service --- We will use AWS RDS MySQL which is fully Managed MySql Database services provided by AWS
2.  Application Load Balancer --- We will use AWS ALB as a single entry point for our Website. ALB will route requests to multiple EC2 behind ALB
3.  Elastic File System --- AWS EFS is fully managed network file system which we will use for storing all our WordPress config files, plugins, WebPages. Another advantage of EFS is we can mount EFS to Multiple EC2 Instances, so that every EC2 Instance points to same files and we can run multiple EC2 to achieve High Availability and Fault Tolerance.

# Task Details

1. Create RDS Instance
2. Create EC2 Instance
3. Create EFS
4. Attach EFS to EC2
5. Install Apache Web Server and Wordpress
6. Create ALB and Target Group
7. Export and Import Wordpress data

# Let's Get Started


### 1. Create Your MySQL Database

-   To begin, go to Amazon RDS in the AWS console. Click the orange Create database button to get started.

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/createDB.png)

-   The first step is to choose the database engine you want to use. WordPress uses MySQL, so we will select MySQL

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/dbEngine.png)

-   Scroll down and select your desired template (I have selected Production)
-   Enter the name of your DB instance identifier
-   Enter Master Username and Password for your Database (make sure you note this down and store it securely)
-   Select your desired instance class
-   Scroll down select if you want your DB to be MultiAZ (I would recommend for creating it as a MultiAZ if you are using it in Prod)
-   Select your VPC and Proper Security group for your RDS
-   Scroll down and in the Additional configuration and write Initial database name (RDS will create database for us)
-   Scroll down and click on Create Database

Make a note of Master Username, Password and Initial DB we will need this info in configuring the WP

### 2. Create EC2 Instance

-   Create EC2 Instance with the Amazon Linux 2 AMI (HVM) in the VPC in which you created RDS
-   In Security Group of RDS open port 3306 in inbound rules and add the EC2 Instance Security group Id, so that EC2 can connect to your RDS MySQL.

### 3. Create EFS

-   Go to EFS console and click on create file system
-   Enter the name of EFS
-   Select the VPC in which you have launched RDS and EC2
-   Select Regional in the Availability and Durability and click on Create

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/statusEFS.png)

AWS EFS

-   once file system is available click on it and click on Edit in General in the Lifecycle management select None, click on save changes. The reason behind doing this is by default if you don't access the object from the file system it will move that object into the Standard --- Infrequent Access storage class
-   Change Throughput Mode to Provisioned and enter the desired value. This will help us in fast reading from the file system during high traffic

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/createEFS.png)

### 4. Attach EFS to EC2

-   Once you are done with the changes SSH into the EC2 Instance and we will attach this file system to EC2 Instance so that it can store the data into file system
-   Create `/var/www/html` directory using following command. We will store all our content under this directory used by Apache Web Server

`sudo mkdir -p /var/www/html/`

-   Mount the file system using following command

`sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <file_system_id>.efs.<region>.amazonaws.com:/ /var/www/html/`

you can get this command from file system console as well. You just need to click on file system and you will see the Attach button, click on that button and you will get the command.

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/mountEFS_0.png)

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/mountEFSCommand.png)

Note: Make sure you replace `efs` with `/var/www/html`

-   Check that file system is mounted to EC2 using following command

`df -T -h`

Now that our file system mount is successful we are good to go ahead but before that we will configure our EC2 Instance to Auto Mount the file system whenever it gets rebooted due to any of the reasons

-   Install the following package

`sudo yum install -y amazon-efs-utils`

-   Open file `/etc/fstab` in your favourite text editor and add the following line

`<file_system_id>.efs.<region>.amazonaws.com:/ /var/www/html/ efs defaults,_netdev 0 0`

Now whenever your EC2 instance gets rebooted due to some reason it will mount the file system automatically.

### 5. Installing the Apache Web Server

-   To run WordPress, you need to run a web server on your EC2 instance. The open source [Apache web server](https://httpd.apache.org/) is the most popular web server used with WordPress.
-   To install Apache on your EC2 instance, run the following command in your terminal:

`sudo yum install -y httpd`

-   start the apache web server

`sudo systemctl start httpd`

-   Enable apache web server to start automatically on boot

`sudo systemctl enable httpd`

-   check the status of httpd

`sudo systemctl status httpd`

Now you can go to browser and hit the **<ec2_public_DNS>** you will see the apache test page. Make sure you have opened port 80 in the SG of EC2

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/testPage.png)

Apache Server Test Page

### 6. Creating Application ALB and Register EC2 in Target Group

-   Go to EC2 Console and click on Load Balancers from the left navigation panel
-   Click on Create Load Balancer button
-   Select Application Load Balancer
-   Enter the name of the Load Balancer
-   Scroll down and select the VPC in which you have launched RDS and EC2 and select Availability Zones (I would recommend to select 2 or more AZs for High Availability) and select proper subnets
-   Click on Next and Select the Security Group for ALB (Make sure your SG has Port 80 opened)
-   In the configure routing

a. Select Create New Target Group

b. Enter the name of TG

c. Select Target Type -> Instance

d. Select HTTP Protocol

e. Write 80 in Port

f. Scroll down to Advanced health check settings

g. In the success codes enter 200, 301 (After Installing WordPress when we will hit the request to ALB endpoint Internally Apache Web Server will Redirect our traffic to WordPress and it will give 301 status code. Flow of the request will be --- Request on ALB Endpoint -> Apache WebServer -> WordPress. So basically our Apache WebServer is redirecting the traffic so success code for TG will be 301). If you don't add 301 in Success Codes while Creating TG your Target Health Check might fail with error Getting 301 status Code

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/healCheck.png)

Note: Add 200 and 301 both the status code because till now when we hit the request the success code will be 200 but after installing and configuring WordPress the success code will be 301. Don't forget to Add the ID of ALB Sg into the inbound rule of EC2 SG.

### 7. Download and Configure WordPress

-   In this step, we will download the WordPress software and set up the configuration.
-   First, download and uncompress the software by running the following commands in your terminal:

```bash
cd /home/ec2-user/
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
```

-   Change into the wordpress directory and create a copy of the default config file using the following commands:

```bash
cd wordpress
cp wp-config-sample.php wp-config.php
```
-   Open the wp-config.php file using in your favourite text editor and We need to edit two areas of configuration.

a. First, edit the database configuration by changing the following lines:
```console
define( 'DB_NAME', 'database_name_here' );/** MySQL database username */\
define( 'DB_USER', 'username_here' );/** MySQL database password */\
define( 'DB_PASSWORD', 'password_here' );/** MySQL hostname */\
define( 'DB_HOST', 'localhost' );
```
**DB_NAME** : The name of the DB which you created while creating RDS MySQL

**DB_USER** : The RDS MySQL Master Username

**DB_PASSWORD** : The RDS MySQL Password

**DB_HOST** : The RDS MySQL Host which you can get it from the RDS Console, click on your Database Instance and you will see the connection endpoint

### 8. Deploying the WordPress

-   In this step, we will make your Apache web server handle requests for WordPress.
-   First, install the application dependencies we need for WordPress. In your terminal, run the following command.

`sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2`

- copy your WordPress application files into the `/var/www/html` directory used by Apache.

`sudo cp -r wordpress/* /var/www/html/`

- change user:group of /var/www/ so that apache(httpd) can access files

`sudo chown -R apache:apache /var/www/`

-   open `/etc/httd/conf/httpd.conf` file and make the following changes

a. Replace the following lines
```console
<Directory />\
    AllowOverride none\
    Require all denied\
</Directory>
```
with the
```console
<Directory />\
    Options FollowSymLinks\
    AllowOverride All\
</Directory>
```
b. scroll down to line no 129 and change `AllowOverride None` to `AllowOverride All`

c. scroll down to line no 155 and change `AllowOverride None` to `AllowOverride All`

-   Final Step, Restart Apache Web Server

`sudo systemctl restart httpd`

Congratulations !!! 🥳 You have successfully Installed the WordPress on AWS Cloud.

Open Your Web browser and hit <ec2_public_dns> you will see the WordPress Configuration Page. Follow the simple steps to configure the WordPress by following the instructions and make sure you securely store your username and password for WordPress Admin

### 9. Make it Highly Available

-   Now as I have told you that we will make this set up as Highly Available, so that because of any reason if our EC2 Instance is down then another Instance should be available to serve the requests
-   We have already created AWS Elastic File System so that we can mount that to Multiple EC2 Instances and we have already moved all our code to EFS which is mounted under `/var/www/html` directory
-   Go to AWS Console and Select your EC2 on  
-   Click on Actions, Click on `Image and Templates` and click on `Create Image` button
-   Enter the name and description of Image most importantly you must select `No Reboot` Enable CheckBox.

![]( https://github.com/hoabka/saa-c02-labs/blob/master/ha-architecture/images/wpmigration/imgTemplate.png)

-   Scroll down and click on Create Image
-   You will get the image id and wait for it to become available
-   Once that image is available launch New EC2 Instance from the Image which you have created
-   You can launch as many instances you want from that image. It will have all our configurations which we have done so far.
-   Once you launch the new instance verify that everything is in place

a. Check that EFS is mounted by running `df -T -h` command

b. Check that you have httpd service running

c. Run `ls /var/www/html` command and you will see all the files are present under that directory because we have mounted file system.

-   Once the above things are verified go to the Target Group which you have created while creating ALB and register you new EC2 Instances in that Target Group

### 10. Data Migration

#### How To Export WordPress Content

-   Log in to the WordPress instance that you wish to migrate.

-   Select the "All-in-One WP Migration -> Export" option.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-1.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-1.png)

-   On the resulting page, click the "Export" button and select the "File" option to export the entire content of your WordPress blog, including plugins and themes. If you click other option you will be redirected to a product page for buying the specific extension to export in the format you have selected.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-2.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-2.png)

-   You will now be prompted to download a ZIP file containing the content to be migrated through your browser.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-3.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-3.png)

-   Save this file to your local system.

#### How To Import WordPress Content

Next, you must import the ZIP file into your new WordPress blog or website. Follow these steps:

-   Log in to the new WordPress instance.

-   Select the "All-in-One WP Migration -> Import" option.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-4.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-4.png)

-   Drag and drop the ZIP file obtained earlier into the page, or click the "File" button on the page and select the ZIP file from your local system.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-5.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-5.png)

The file will now be uploaded to the new WordPress instance. You will see a progress bar indicating the progress of the upload.

-   Click the "Continue" button for finishing the exportation process.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-6.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-6.png)

-   Once the file is successfully uploaded, the content within it will be automatically transferred to the new WordPress instance and you will be prompted to log in to the WordPress dashboard again.

> NOTE: At this point, you must log in using the credentials for the original imported WordPress instance.

-   You will now be presented with a success page. Click the "Permalinks Settings" link to proceed.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-7.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-7.png)

-   Verify the permalink settings on the resulting page. In most cases, no changes will be necessary. Click "Save Changes" to save your changes.

    [![WordPress migration](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-8.png)](https://docs.bitnami.com/images/img/apps/wordpress/wordpress-migrate-8.png)

Your content should now be fully migrated and usable on the new WordPress instance.

Congratulations !!
==================

You have successfully Installed and Configured WordPress on AWS Instances with the High Availability.

If you have the WordPress Backup file available you can also upload that backup file and it will run smoothly. WordPress has many plugins available for Exporting and Importing the backup.

Thank You!
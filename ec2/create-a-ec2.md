# Get started with Amazon EC2 Linux instances
In this tutorial, you'll learn how to launch, connect to, and use a Linux instance. An instance is a virtual server in the AWS Cloud. With Amazon EC2, you can set up and configure the operating system and applications that run on your instance.

## Overview
The instance is an Amazon EBS-backed instance (meaning that the root volume is an EBS volume). You can either specify the Availability Zone in which your instance runs, or let Amazon EC2 select an Availability Zone for you. You can think of an Availability Zone as an isolated data center.

When you launch your instance, you secure it by specifying a key pair (to prove your identity) and a security group (which acts as a virtual firewall to control ingoing and outgoing traffic). When you connect to your instance, you must specify the private key of the key pair that you specified when launching your instance.

![
				An Amazon EBS-backed instance with an additional Amazon EBS volume
			](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/overview_getting_started.png)



## Step 1: Launch an instance

1.  Open the Amazon EC2 console at <https://console.aws.amazon.com/ec2/>.

2.  From the console dashboard, choose Launch Instance.

3.  The Choose an Amazon Machine Image (AMI) page displays a list of basic configurations, called *Amazon Machine Images (AMIs)*, that serve as templates for your instance. Select the **Amazon Linux 2 AMI (HVM)**

4.  On the Choose an Instance Type page, you can select the hardware configuration of your instance. Select the `t3.micro` instance type. 
5.  On the Choose an Instance Type page, choose **Next: Configure Instance Details**

6. In the **Configure Instance Details** page, specify these configurations:
- **Network**: Use default VPC(Virtual Private Cloud) or you can create a new one.
- **Subnet**: Choose the public subnet you want to launch the Instance in
- **Auto-assign Public IP**: Enable
Then choose **Next: Add Storage**

7. In the storage page, you can modify volume size, type or attach/delete volumes. For example, change volume size to 20GiB, Volume type to General Purpose SSD (GP3). Then choose **Next: Add tags**

8. Add tags for the Instance, for example **Key: Name, Values: Test EC2**, then choose **Next: Configure Security Group**

9. In the security group page, choose the existed security group or create a new one:
- **Security group name**: name of the security group
- **Description**: For example `Allow from my computer`
- **Type**: SSH
- **Source**: Choose **My IP**

Then choose **Review and Launch**

7.  On the Review Instance Launch page, choose Launch.

8.  When prompted for a key pair, select **Create a new key pair**, enter the key name, Download the key pair and click to **Launch Instances**

    >    Warning  
        Don't select Proceed without a key pair. If you launch your instance without a key pair, then you can't connect to it.  


9.  A confirmation page lets you know that your instance is launching. Choose View Instances to close the confirmation page and return to the console.

10. On the Instances screen, you can view the status of the launch. It takes a short time for an instance to launch. When you launch an instance, its initial state is `pending`. After the instance starts, its state changes to `running` and it receives a public DNS name. (If the Public IPv4 DNS column is hidden, choose the settings icon ( ![](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/settings-icon.png) ) in the top-right corner, toggle on Public IPv4 DNS, and choose Confirm.

11. It can take a few minutes for the instance to be ready so that you can connect to it. Check that your instance has passed its status checks; you can view this information in the Status check column.
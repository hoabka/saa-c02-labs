# Overview

This lab shows how to create an Amazon Virtual Private Cloud (VPC) using AWS CloudFormation.
Using AWS CloudFormation is an excellent way to deploy VPCs in a reliable, repeatable manner because the
template used by CloudFormation acts as documentation to show exactly what is being deployed.
You will walk through sections of an AWS CloudFormation template and examine the resources that are deployed.
You will also learn how to perform updates through CloudFormation.

# Lab Details
 
1. This lab walks you through the step by step procedure on how to provision Infrastructure on AWS using AWS CloudFormation.

2. Duration: **1 Hour 30 minutes**

3. AWS Region: **N. Virginia (us-east-1)**

# Architecture Diagram

![](https://github.com/hoabka/saa-c02-labs/blob/master/cicd/images/cloudformation/architecture.png)

# AWS Service
1. CodeCommit - CloudFormation
2. VPC

# Task Details

In this lab you will:

1. Deploy an AWS CloudFormation template that creates an Amazon VPC
2. Examine the components of the template
3. Update a CloudFormation stack
4. Examine a template with the AWS CloudFormation Designer
5. Delete a CloudFormation stack

## Task 1: Deploy a Stack using AWS CloudFormation

In this task, you will deploy a pre-defined template to build a VPC.

You will examine the contents of the template in the next task.

1. In the **AWS Management Console**, on the Services menu, click **CloudFormation**.
2. Click **Create stack > With new resources**, then configure:
- Click **Upload a template file**
- Click **Choose file**
- Browse to and select the **resources/cloudformation/vpc-1.yaml** file in lab resource
- Click **Next**
3. On the **Create stack** page, configure:
- Stack name: Follow naming convention **<Your_Account>** (example: hoanguye )
- In Parameters, VPCName: Typing Your VPC follow convention **<Your_Account>-vpc** (Example:
    hoanguyen-vpc)
- Click **Next**

The **Options** page allows you to specify Tags, Permissions and Advanced Options.

1. On the **Configure stack options** page, scroll to the bottom of the screen, then click **Next**

You will use the default values.

1. On the **Review** page:


- Review the configuration
- Click **Create stack**

The stack status will be CREATE_IN_PROGRESS until the resources have been created.
While you are waiting, look in the **Events** tab to view the work being performed by CloudFormation.

If you do not see the **Events** tab, it is because your web browser window is too narrow. Either make the window
wider until the tabs appear, or click the pull-down arrow in the **Overview** tab.

1. Click the **Stack info** tab.
2. Wait until the status changes to **CREATE_COMPLETE**. Click the Refresh icon every 30 seconds to update
    the status.

When the stack status is **CREATE_COMPLETE**, it means that the resources have been created.

1. Click the Resources tab.

A list of **resources** is displayed. These resources will be explained in the next task. You may need to refresh the
screen to see the resources.

# Task 2: Examine the VPC

In this task, you will examine the VPC resources that were created together with the code from the
CloudFormation template that created the resources.
Here are the resources that have been created by CloudFormation:

![](https://github.com/hoabka/saa-c02-labs/blob/master/cicd/images/cloudformation/task2.png)

- An Amazon VPC
- An Internet Gateway
- Two Subnets
- Two Route Tables


These resources all reside within one **Availability Zone**. An Availability Zone is an isolated location within a
Region and consists of one or more data centers.

1. On the **Services** menu, click **VPC**.
2. In **Filter by VPC** in the top-left corner, select **Your VPC**.

This configures the VPC console to only display resources that belong to the VPC created by CloudFormation.

1. In the left navigation pane, click **Your VPCs**.
2. Select **Your VPC**.

The **Description** tab displays the **IPv4 CIDR**, which is a range of IP addresses assigned to the VPC. This VPC has
a CIDR of 10.0.0.0/16, which means it contains all IP addresses that start with 10.0.x.x
Here is the code from the CloudFormation template that created this VPC:

```console
AWSTemplateFormatVersion: 2010-09-09 
Description: Deploy a VPC
Parameters:
  VPCName:
    Type: String
    Description: Enter Your VPC Name
Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsHostnames: true
      Tags:
      - Key: Name
        Value: !Ref VPCName
```

This code is in YAML format. AWS CloudFormation can also accept code in JSON format. If you are more familiar
with JSON, you can download the JSON version of this template.

The **Type** parameter in the above code declares the type of resources being created by CloudFormation. The
**Properties** section then specifies more information about the resource to create. In this case, it defines:

- **CidrBlock**: The IP address range associated with the VPC.
- **EnableDnsHostnames**: Configures the VPC to associate DNS names with Amazon EC2 instances.
- **Tags**: Adds a friendly name to the resource.

Each type of resource has a different set of properties that can be used.

1. In the left navigation pane, click **Internet Gateways**.

An Internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows
communication between instances in your VPC and the Internet. It therefore imposes no availability risks or
bandwidth constraints on your network traffic.


An Internet gateway serves two purposes: to provide a target in your VPC route tables for Internet-routable traffic
and to perform network address translation (NAT) for instances that have been assigned public IPv4 addresses.
Here is the code from the CloudFormation template that created this Internet Gateway:

```console
InternetGateway:
    Type: AWS::EC2::InternetGateway
    Properties:
      Tags:
      - Key: Name
        Value: Lab Internet Gateway
```

In the management console, the Internet Gateway is showing that it is attached to the VPC. This was done with this
code in the CloudFormation template:

```console
AttachGateway:
Type: AWS::EC2::VPCGatewayAttachment Properties:
VpcId: !Ref VPC
InternetGatewayId: !Ref InternetGateway

```

AttacGateway: Type: AWS::EC2::VPCGatewayAttachment Properties: VpcId: !Ref VPC InternetGatewayId: !Ref
InternetGateway
A VPC Gateway Attachment creates a relationship between a VPC and a gateway, such as this Internet Gateway.
Notice that the template refers to other elements in the template with the !Ref keyword, followed by the name of the
other resource. This makes it easy to build resources that link to each other simply by referencing their name.

1. In the left navigation pane, click **Subnets**.

Two subnets will appear:

- **Public Subnet 1** is connected to the Internet via the Internet Gateway and can be used by resources that
    need to be publicly accessible.
- **Private Subnet 1** is not connected to the Internet. Any resources in this subnet cannot be reached from the
    Internet, thereby providing additional security around these resources.

Here is the code from the CloudFormation template that created the subnets:

```console
 PublicSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.0.0/24
      AvailabilityZone: !Select
- '0'
        - !GetAZs ''
      Tags:
        - Key: Name
          Value: Public Subnet 1
  PrivateSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select
- '0'
- !GetAZs ''
      Tags:
        - Key: Name
          Value: Private Subnet 1
```

The properties are:

- **VpcId** refers to the VPC that contains the subnet.
- **CidrBlock** is the range of IP address assigned to the subnet.
- **AvailabilityZone** defines which physical location within the Region should contain the subnet.

Note that the Availability Zone is using a function called !Select and a function called !GetAZs. The code is
retrieving a list of Availability Zones within the region and is referencing the first element from the list. In this
manner, the template can be used in any region because it retrieves the list of Availability Zones at runtime rather
than having the Availability Zones hard-coded in the template.

1. In the left navigation pane, click **Route Tables**.
2. Select the **Public Route Table**.
3. Click the **Routes** tab in the lower half of the window.

Route Tables are used to direct (or route) traffic in and out of subnets. The configuration for this route table is:

- For traffic within the VPC (10.0.0.0/16), route the traffic locally.
- For traffic going to the Internet (0.0.0.0/0), route the traffic to the Internet Gateway (indicated by igw-).

Here is the code from the CloudFormation template that created the Public Route Table:

````console
  PublicRouteTable:
    Type: AWS::EC2::RouteTable
    Properties:
      VpcId: !Ref VPC
      Tags:
        - Key: Name
          Value: Public Route Table
````

There is also a similar code for the Private Route Table.
Here is the code that defined the route to the Internet within the Public Route Table:

````console
PublicRoute:
    Type: AWS::EC2::Route
    Properties:
      RouteTableId: !Ref PublicRouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref InternetGateway
````

The configuration for the route is:

- **RouteTableId** indicates the Route Table that owns the route.
- **DestinationCidrBlock** defines the IP address range for this routing rule (where 0.0.0.0/0 refers to traffic
    bound for the Internet).
- **GatewayId** defines where to route the traffic, which in this case is the Internet Gateway that was defined
    earlier in the template.

This Route is only configured for the Public Route Table, which is what makes it public.

1. Click the **Subnet Associations** tab.


The console shows that the Public Route Table is associated with Public Subnet 1. A Route Table can be associated
with multiple subnets, with each association requiring an explicit linkage.

Here is the code that defined this linkage:

````console
PublicSubnetRouteTableAssociation1:
Type: AWS::EC2::SubnetRouteTableAssociation Properties:
      SubnetId: !Ref PublicSubnet1
      RouteTableId: !Ref PublicRouteTable
````

It declares that **Public Subnet 1** is associated with the **Public Route Table**.
In addition to creating resources, CloudFormation can provide information about the resources that have been
created.

1. On the **Services** menu, click **CloudFormation**.
2. Click the **Lab stack**.
3. Click the **Outputs** tab.

The CloudFormation template has been configured to return information about the resources it created:

- **VPC** is the ID of the VPC that was created.
- **AZ1** shows the Availability Zone in which the Subnets were created.

Here is the code that configured the Outputs:

```console
Outputs:
  VPC:
    Description: VPC
    Value: !Ref VPC
  AZ1:
    Description: Availability Zone 1
    Value: !GetAtt
      - PublicSubnet1
      - AvailabilityZone
```

The VPC output is simply a reference to the VPC, which results in the VPC ID being displayed.
The AZ1 output uses the !GetAtt function to retrieve an attribute of the resources. In this case, it is retrieving the
AvailabilityZone attribute from Public Subnet 1.

# Task 3: Updating a Stack

Once a CloudFormation stack has been deployed, it is recommended that any changes to the resources should be
made through CloudFormation rather than by directly modifying the resources.

In this task, you will update the stack with a new CloudFormation template that defines the following resources:

![](https://github.com/hoabka/saa-c02-labs/blob/master/cicd/images/cloudformation/task2.png)

Additional public and private subnets have been added in another Availability Zone. This is the best practice to
ensure that your resources can run in multiple data centers (Availability Zones) to ensure High Availability in case
of system failures.

1. Click **Update**, then configure:
- Select **Replace current template**
- Click **Upload a template file**
- Click **Choose file**
- Select the **resources/cloudformation/vpc-2.yaml** template in lab resource
1. Click Next
2. Click Next

You will accept the default Options.

1. Scroll to the bottom of the screen, then click **Next**

Examine the **Change set preview** section at the bottom of the page. It is displaying what will happen when the stack
is updated:

It indicates that two new Subnets will be created. In addition, two Route Table Associations will be added, to associate
these Subnets with their appropriate Route Tables.

1. Scroll to the bottom of the screen, then click **Update stack**

Examine the **Events** tab while the stack is updating.

1. Click the **Stack info** tab.

Click the Refresh occasionally until the status is **UPDATE_COMPLETE**.

1. Click the **Outputs** tab.

An additional Availability Zone is displayed, with a different value to the original Availability Zone.

1. On the **Services** menu, click **VPC**.
2. In Filter by VPC in the top-left corner, select **Your VPC**.


3. In the left navigation pane, click **Subnets**.

Four subnets are now displayed. Click each of them and examine their settings in the **Route Table** tab.
The VPC has now been updated to support Highly Available applications.

# Task 4: Viewing a Stack in CloudFormation Designer

In this task, you will view the template using the AWS CloudFormation Designer.

AWS CloudFormation Designer (Designer) is a graphic tool for creating, viewing, and modifying AWS
CloudFormation templates. With Designer, you can diagram your template resources using a drag-and-drop
interface, and then edit their details using the integrated JSON and YAML editor. Whether you are a new or an
experienced AWS CloudFormation user, AWS CloudFormation Designer can help you quickly see the
interrelationship between a template's resources and easily modify templates.

1. On the **Services** menu, click **CloudFormation**.
2. Click the **Your stack**.
3. Click the **Template** tab.
4. Click **View in Designer**

The top portion of the window provides a graphical overview of the VPC that is defined by the template.

1. Use the Zoom controls to examine the diagram. You can move the diagram by dragging the image.
2. At the bottom of the page, click the **Components** tab.
3. Click on some elements in the diagram.

The lower portion of the window displays the code within the template that defines the resource.
Arrows show the relationship between resources, such as Route Tables that are associated with Subnets.

1. Choose template language, click JSON.

The Designer can also convert code between JSON and YAML formats.

# Task 5: Delete the Stack

In this task, you will delete the stack, which will automatically delete the VPC and its components.

1. At the top-left of the screen, click the **Close** link.

This will exit the Designer. If prompted, click **Leave Page** to exit.

1. Select the **Your stack**.
2. Click Delete, then click **Delete stack**
3. Click the Events tab to view details of the deletion.

Click Refresh until the stack is deleted.
When the stack has been deleted, it will disappear from the list.
Your VPC has also been deleted.

1. On the **Services** menu, click **VPC**.
2. In the left navigation pane, click **Your VPCs**.


The **Your VPC** is no longer listed. In addition, the associated **Internet Gateway, Subnets and Route Tables** have
been deleted.

# Conclusion

Congratulations! You now have successfully learned how to:

- Deploy an AWS CloudFormation template that creates an Amazon VPC
- Examine the components of the template
- Update a CloudFormation stack
- Examine a template with the AWS CloudFormation Designer
- Delete a CloudFormation stack

# End Lab



# Creating an S3 VPC Endpoint
A VPC endpoint allows EC2 instances the ability to talk to services that are configured behind a VPC endpoint without having to traverse the public internet. A prime use case for creating a VPC endpoint would be to allow EC2 instances access to S3 buckets via their private subnets. In this scenario, we will set up an EC2 instance that has no internet connectivity, but will have the ability to still send data to a configured S3 bucket via the VPC endpoint directly. Using a VPC endpoint allows the object to go direct between the EC2 instance and the S3 bucket internally, both saving egress and ingress cost, as well as allowing for faster and more performance for read/writes to/from the bucket because the traffic does not have to hairpin, or traverse a public hop. Once our setup is complete, our VPC should operate like the following diagram

![VPCE Flow](http://beta.awsdocs.com/assets/images/tuts/Services/VPC/CreateS3VPCEndpoint/vpc_endpoint_diagram.png)

## VPC Endpoint Pre-Requisites
1. A S3 private bucket(same region with EC2 Instances)
2. Bastion Host EC2 Instance(Public SSH)
3. Application Host EC2 Instance(Private with S3 fullaccess role) Amazon Linux 2 recommended.
## Configure S3 VPC Endpoint
**1\. Create VPC Endpoint:**\
From the VPC console left menu, click on **Endpoints**, and then click the **Create Endpoint** button  
2. In the **Service Name**, search for S3 and choose **com.amazonaws.ap-southeast-1.s3** and type **Gateway** If you are in ap-southeast-1 region.  
3. Choose the VPC and route table you want to attach to(private route table)  
4. In the **Policy**, select **Custom** and paste following policy:
>
    {
        "Statement": [
            {
                "Action": "*",
                "Effect": "Allow",
                "Resource": "arn:aws:s3:::bucketname/*",
                "Principal": "*"
            }
        ]
    }
5. Choose **Create endpoint**

## Test the endpoint connection

1. Connect to private EC2
2. Run following command:
>      aws configure  
        AWS Access Key ID [None]:
        AWS Secret Access Key [None]:
        Default region name [None]: ap-southeast-1 (your region)
        Default output format [None]:
2. Create a file, for example run command 
>       touch file.abc
3. Upload the file to S3 bucket:  
>       aws s3 cp file.abc s3://bucketname/  
the result should be like:   
>       upload: ./file.abc to s3://saa-s3-k1/file.abc
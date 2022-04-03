# Terraform

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language (HCL), or optionally JSON.

Terraform supports a number of cloud infrastructure providers such as Amazon Web Services, IBM Cloud (formerly Bluemix), Google Cloud Platform, Linode, Microsoft Azure, Oracle Cloud Infrastructure, or VMware vSphere as well as OpenStack

Since this is going to be the process of  Infrastructure as a Code paradigm. We need a API programmatic access for AWS.


### Terraform Core concepts
- Variables: Also used as input-variables, it is key-value pair used by Terraform modules to allow customization.
- Provider: It is a plugin to interact with APIs of service and access its related resources.
- Module: It is a folder with Terraform templates where all the configurations are defined
- State: It consists of cached information about the infrastructure managed by Terraform and the related configurations.
- Resources: It refers to a block of one or more infrastructure objects (compute instances, virtual networks, etc.), which are used in configuring and managing the infrastructure.
- Data Source: It is implemented by providers to return information on external objects to terraform.
- Output Values: These are return values of a terraform module that can be used by other configurations.
- Plan: It is one of the stages where it determines what needs to be created, updated, or destroyed to move from real/current state of the infrastructure to the desired state.
- Apply: It is one of the stages where it applies the changes real/current state of the infrastructure in order to move to the desired state.

### Terraform Lifecycle
Terraform lifecycle consists of – **init**, **plan**, **apply**, and **destroy**.

- Terraform **init** initializes the working directory which consists of all the configuration files
- Terraform **plan** is used to create an execution plan to reach a desired state of the infrastructure. Changes in the configuration files are done in order to achieve the desired state.
- Terraform **apply** then makes the changes in the infrastructure as defined in the plan, and the infrastructure comes to the desired state.
- Terraform **destroy** is used to delete all the old infrastructure resources, which are marked tainted after the apply phase.


### Download and Install Terraform CLI
Terraform is a Single file binary which you can download and run it without any additional installation.

To make this precise and Short I have not added the installation instruction of Terraform. You can find the instructions here [Installing Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Now Let me proceed further with an assumption that you have installed the Terraform CLI.

### Authentication with AWS
In order to connect to AWS. Terraform has to successfully authenticate. It is done with the help of Programmatic API Keys (Access Key and Secret.)

Some Sample usage of these API Keys in a terraform configuration.
```
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```

### AWS config Profile
Download and setup [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### Labs
In this lab we using terraform to create resource as a below

![](https://github.com/hoabka/saa-c02-labs/blob/master/cicd/images/terraform/aws-networks.png)

- VPC
- Internet gateway
- Subnet
- Route table
- NAT Gateway
- EC2, Security Group
- MYSQL RDS

Inside terraform code folder
- terraform init
- terraform plan
- terraform apply 

### Delete resource 
Inside terraform code folder
- terraform destroy
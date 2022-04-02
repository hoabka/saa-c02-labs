# Overview

AWS Command Line Interface (AWS CLI)

![](https://github.com/hoabka/saa-c02-labs/blob/master/iam/images/aws-cli/overview.png)

# Lab Details
 
1. This lab walks you through the step by step procedure on how to migrate an existing Wordpress site to an AWS with High Availibility and Scalibility.

2. Duration: **1 Hour 30 minutes**

3. AWS Region: **N. Virginia (us-east-1)**

# Task Details
1. Installing AWS CLI
2. Configure AWS Credential
3. Using AWS CLI to create IAM user/Group/Policy
4. Challenges

### 1. Installing AWS CLI

First, you need to download the AWS CLI. Depending on your operating system, it will require a different method.

#### Linux / macOS / Unix

**Prerequisites:**

You must ensure that you have at least Python 3 version 3.3+ installed. To verify your current version, run the command:

`python3 --version`

**Installation:**
[Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### 2. Configure AWS Credential
-----------------------------------

Once you have installed the AWS CLI, you now need to configure the application to be able to connect to your AWS account.  To do so, enter the following from your command prompt:

`aws configure`

Through *aws configure**,* the AWS CLI will prompt you for four pieces of information. The first two are required. These are your AWS access key ID and AWS secret access key, which serve as your account credentials. You can generate new credentials within AWS Identity and Access Management (IAM) if you do not already have them. The other information you will need is region and output format, which you can leave as default for the time being.

```console
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

The default region name simply defines the Region where you requests will be sent to. For all available regions, please see the following: [Regions and Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html). 

The default output format specifies how the results are formatted. Values that can be used here include: 

-   json 
-   text
-   table

The AWS access key ID and AWS secret access key are used to authenticate your AWS account. This authorizes you to carry out specific tasks and functions as defined by your permissions level.  

The AWS access key ID is made up of 20 random uppercase alphanumeric characters, such as the one displayed on screen.

The AWS secret access key is made up of 40 random upper and lowercase alphanumeric and non-alphanumeric characters as displayed.

These access keys can be created for any IAM user who requires authentication from a programmatic perspective, such as when using the AWS CLI.


> IMPORTANT: When the access keys are created, you are prompted to download and save the details. The secret access key ID will only be displayed once, and if you lose it, then you'll have to delete the associated access key ID and recreate new keys for the user.

### 3. Using AWS CLI to create IAM user

#### 3.1 Create IAM user

`aws iam create-user --user-name Bob`

**Output**
```console
{
    "User": {
        "UserName": "Bob",
        "Path": "/",
        "CreateDate": "2022-01-08T03:20:41.270Z",
        "UserId": "AIDAIOSFODNN7EXAMPLE",
        "Arn": "arn:aws:iam::123456789012:user/Bob"
    }
}
```

#### 3.2 Create Login Profile for User

- Generate  login profile skeleton

`aws iam create-login-profile --generate-cli-skeleton > create-login-profile.json`

- Edit information for user/password

```console
$ vi create-login-profile.json

# Edit User/pass information as following

{
    "UserName": "Bob",
    "Password": "123123a@",
    "PasswordResetRequired": true
}
```

- Create Login Profile

`aws iam create-login-profile --cli-input-json file://create-login-profile.json`

**Output**
```console
{
    "LoginProfile": {
        "UserName": "Bob",
        "CreateDate": "2022-01-08T20:55:40.274Z",
        "PasswordResetRequired": true
    }
}
```

#### 3.3 Let's try with new user

### 4. Challenges
**Using AWS CLI to**
1. Create Group named `Ops`
2. Creat `Policy` with `EC2FullAccess` permission and then attach to `Ops` group
3. Add User `Bob` to `Ops` group
4. Login again with user Bob and veriry EC2 permission available or not.

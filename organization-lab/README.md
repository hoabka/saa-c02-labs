# Creating and configuring an organization
The tutorial also shows you how to use a [deny list](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#denylist) to ensure that no users in a member account can change the configuration for the auditing logs that AWS CloudTrail creates.

The following illustration shows the main steps of the tutorial.

![](https://docs.aws.amazon.com/organizations/latest/userguide/images/tutorialorgs.png)

## Step 1: Create your organization
In this step, you sign in to administrator, create an organization with that account as the management account.
1.  Sign in to AWS as an administrator of account and open the [AWS Organizations console](https://console.aws.amazon.com/organizations/v2).

2.  On the introduction page, choose Create an organization.

3.  In the confirmation dialog box, choose Create an organization.

    >    Note  
    By default, the organization is created with all features enabled. You can also create the organization with only [consolidated billing features](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#feature-set-cb-only) enabled.
    AWS creates the organization and shows you the [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts) page. If you're on a different page then choose AWS accounts in the navigation pane on the left.
    If the account you use has never had its email address verified by AWS, a verification email is automatically sent to the address that is associated with your management account. There might be a delay before you receive the verification email.

4.  Verify your email address within 24 hours. For more information, see [Email address verification](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_create.html#about-email-verification).

### Invite an existing account to join your organization

Now that you have an organization, you can begin to populate it with accounts. In the steps in this section, you invite an existing account to join as a member of your organization.

1.  Navigate to the [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts) page, and choose Add an AWS account.

2.  On the [Add an AWS account](https://console.aws.amazon.com/organizations/v2/home/accounts/add/create) page, choose Invite an exisiting AWS account.

3.  In the box Email address or account ID of an AWS account to invite box, enter the email address of the owner of the account that you want to invite, similar to the following: `member222@example.com`. Alternatively, if you know the AWS account ID number, then you can enter it instead.

4.  Type any text that you want into the Message to include in the invitation email message box. This text is included in the email that is sent to the owner of the account.

5.  Choose Send invitation. AWS Organizations sends the invitation to the account owner.

    >    Important  
    If you get an error that indicates that you exceeded your account limits for the organization or that you can't add an account because your organization is still initializing, wait until one hour after you created the organization and try again. If the error persists, contact [AWS Support](https://console.aws.amazon.com/support/home#/).

6.  For the purposes of this tutorial, you now need to accept your own invitation. Do one of the following to get to the Invitations page in the console:

    -   Open the email that AWS sent from the management account and choose the link to accept the invitation. When prompted to sign in, do so as an administrator in the invited member account.

    -   Open the [AWS Organizations console](https://console.aws.amazon.com/organizations/v2) and navigate to the [Invitations](https://console.aws.amazon.com/organizations/v2/home/accounts/invitations) page.

7.  On the [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts) page, choose Accept and then choose Confirm.

8.  Sign out of your member account and sign in again as an administrator in your management account.

Step 2: Create the organizational units
---------------------------------------

In the steps in this section, you create organizational units (OUs) and place your member accounts in them. When you're done, your hierarchy looks like the following illustration. The management account remains in the root. One member account is moved to the Production OU, and the other member account is moved to the MainApp OU, which is a child of Production.

![](https://docs.aws.amazon.com/organizations/latest/userguide/images/orgs-lab-structure.jpg)

1.  On the [AWS Organizations console](https://console.aws.amazon.com/organizations/v2) navigate to the [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts) page.

2.  Choose the check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) next to the Root container.

3.  On the Children tab, choose Actions, and then under Organizational unit, choose Create new.

4.  On the Create organizational unit in Root page, for the Organizational unit name, enter `Production` and then choose Create organizational unit.

5.  Choose the check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) next to your new Production OU.

6.  Choose Actions, and then under Organizational unit, choose Create new.

7.  On the Create organizational unit in Production page, for the name of the second OU, enter `MainApp` and then choose Create organizational unit.

    Now you can move your member accounts into these OUs.

8.  Return to the [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts) page, and then expand the tree under your Production OU by choosing the triangle ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/expand-icon.png) next to it.

    This displays the MainApp OU as a child of Production.

9.  Choose the check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) , (not its name), choose Actions, and then under AWS account, choose Move.

11. Choose the account name, then choose the check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) , not its name), choose Actions, and then under AWS account, choose Move.

12. On the Move AWS account '`member-account-name`' dialog box, the triangle next to Production to expand that branch and expose MainApp.

13. Choose the radio button ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/radio-button-selected.png) , not its name) and then under AWS account, choose Move AWS account.

Step 3: Create the service control policies
-------------------------------------------

In the steps in this section, you create a[service control policies (SCPs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) and attach It to the root and to the OUs to restrict what users in the organization's accounts can do. The  SCP prevents anyone in any of the member accounts from perform any action on S3 bucket.

### Enable the service control policy type for the organization

Before you can attach a policy of any type to a root or to any OU within a root, you must enable the policy type for the organization. Policy types aren't enabled by default. The steps in this section show you how to enable the service control policy (SCP) type for your organization.

1.  Navigate to the [Policies](https://console.aws.amazon.com/organizations/v2/home/policies) page, and then choose Service Control Policies.

2.  On the [Service control policies](https://console.aws.amazon.com/organizations/v2/home/policies/service-control-policy) page, choose Enable service control policies.

    A green banner appears to inform you that you can now create SCPs in your organization.

### Create your SCPs

Now that service control policies are enabled in your organization, you can create the policy that you need for this tutorial.
To create the first SCP that blocks S3 actions

1.  Navigate to the [Policies](https://console.aws.amazon.com/organizations/v2/home/policies) page, and then choose Service Control Policies.

2.  On the [Service control policies](https://console.aws.amazon.com/organizations/v2/home/policies/service-control-policy) page, choose Create policy.

    >Note  
    The service control policy editor is currently available only in the original version of the AWS Organizations console. When you complete your edits, you'll automatically return to the new version of the console.

3.  For Policy name, enter `Block S3`.

4.  In the Policy section, in the policy statement like below:

        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "Stmt1234567890123",
            "Effect": "Deny",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "*"
            ]
            }
        ]
        }
6. Choose Create policy.

## Step 4: Testing your organization's policies
You now can sign in as a user in any of the member accounts and try to perform S3 actions. You will see the message like `You don't have permissions to list buckets`
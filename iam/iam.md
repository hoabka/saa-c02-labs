![AWS group users](https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/modules/aws-identity-and-access-management/manage-iam-users-and-groups/images/73849a97c9d1610ce054fea3f7f4a1e9_9-dc-02-b-99-8-a-91-4-e-40-aa-34-1-c-1-e-1-b-902-d-29.png)
# Creating your first IAM admin user and user group
As a [best practice](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials), do not use the AWS account root user for any task where it's not required. Instead, create a new IAM user for each person that requires administrator access. Then make those users administrators by placing the users into an "Administrators" user group to which you attach the `AdministratorAccess` managed policy.

Thereafter, the users in the administrators user group should set up the user groups, users, and so on, for the AWS account. All future interaction should be through the AWS account's users and their own keys instead of the root user. However, to perform some account and service management tasks, you must log in using the root user credentials.

## Creating an administrator IAM user and user group
This procedure describes how to use the AWS Management Console to create an IAM user for yourself and add that user to a user group that has administrative permissions from an attached managed policy.

**To create an administrator user for yourself and add the user to an administrators user group** 

1.  Sign in to the [IAM console](https://console.aws.amazon.com/iam/) as the account owner by choosing **Root user** and entering your AWS account email address. On the next page, enter your password.

    Note

    We strongly recommend that you adhere to the best practice of using the `Administrator` IAM user below and securely lock away the root user credentials. Sign in as the root user only to perform a few [account and service management tasks](https://docs.aws.amazon.com/general/latest/gr/aws_tasks-that-require-root.html).

2.  Enable access to billing data for the IAM admin user that you will create as follows:

    1.  On the navigation bar, choose your account name, and then choose **Account**.

    2.  Rolling down to **IAM User and Role Access to Billing Information**, choose **Edit**. You must be signed in as the root user for this section to be displayed on the account page.

    3.  Select the check box to **Activate IAM Access** and choose **Update**.

    4.  On the navigation bar, choose **Services** and then **IAM** to return to the IAM console.

3.  In the navigation pane, choose **Users** and then choose **Add users**.

4.  On the **Details** page, do the following:

    1.  For **User name**, type `Administrator`.

    2.  Select the check box for **Password - AWS Management Console access**, select **Custom password**, and then type your new password in the text box.

    3.  By default, AWS forces the new user to create a new password when first signing in. You can optionally clear the check box next to **User must create a new password at next sign-in** to allow the new user to reset their password after they sign in.

    4.  Choose Next: Permissions.

5.  On the **Permissions** page, do the following:

    1.  Choose **Add user** to group.

    2.  Choose **Create group**.

    3.  In the **Create group** dialog box, for Group name type `Administrators`.

    4.  Select the check box for the **AdministratorAccess** policy.

    5.  Choose **Create group**.

    6.  Back on the page with the list of user groups, select the check box for your new user group. Choose Refresh if you don't see the new user group in the list.

    7.  Choose **Next: Tags**.

6.  (Optional) On the **Tags** page, add metadata to the user by attaching tags as key-value pairs. For more information, see [Tagging IAM resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html).

7.  Choose **Next: Review**. Verify the user group memberships to be added to the new user. When you are ready to proceed, choose **Create user**.

8.  (Optional) On the **Complete** page, you can download a .csv file with login information for the user, or send email with login instructions to the user.

You can use this same process to create more user groups and users and to give your users access to your AWS account resources.
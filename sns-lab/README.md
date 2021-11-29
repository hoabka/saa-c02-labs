# Setting up an Amazon SNS topic using the AWS Management Console
cribe to an SNS topic

1.  Open the Amazon SNS console at <https://console.aws.amazon.com/sns/v3/home>.

2.  In the navigation pane, choose Subscriptions, Create subscription.

3.  In the Create subscription dialog box, for Topic ARN, paste the topic ARN that you created in the previous task.

4.  For Protocol, choose Email.

5.  For Endpoint, enter an email address that you can use to receive the notification, and then choose Create subscription.

6.  From your email application, open the message from AWS Notifications and confirm your subscription.

    Your web browser displays a confirmation response from Amazon SNS.

To publish a test message to an SNS topic

1.  Open the Amazon SNS console at <https://console.aws.amazon.com/sns/v3/home>.

2.  In the navigation pane, choose Topics.

3.  On the Topics page, select a topic and choose Publish to topic.

4.  In the Publish a message page, for Subject, enter a subject line for your message, and for Message, enter a brief message.

5.  Choose Publish Message.

6.  Check your email to confirm that you received the message.
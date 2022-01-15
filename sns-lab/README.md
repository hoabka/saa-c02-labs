# Setting up an Amazon SNS topic using the AWS Management Console

## Create SNS Topic

1. Sign in to the Amazon SNS console.
1.  On the Topics page, choose Create topic.

2.  On the Create topic page, in the Details section, do the following:

    1.  For Type, choose Standard.

    2.  Enter a Name for the topic. 

    3.  (Optional) Enter a Display name for the topic.
    4. Choose Create topic.

## Subscribe to an SNS topic

1.  Open the Amazon SNS console at <https://console.aws.amazon.com/sns/v3/home>.

2.  In the navigation pane, choose Subscriptions, Create subscription.

3.  In the Create subscription dialog box, for Topic ARN, paste the topic ARN that you created in the previous task.

4.  For Protocol, choose Email.

5.  For Endpoint, enter an email address that you can use to receive the notification, and then choose Create subscription.

6.  From your email application, open the message from AWS Notifications and confirm your subscription.

    Your web browser displays a confirmation response from Amazon SNS.

## To publish a test message to an SNS topic

1.  Open the Amazon SNS console at <https://console.aws.amazon.com/sns/v3/home>.

2.  In the navigation pane, choose Topics.

3.  On the Topics page, select a topic and choose Publish to topic.

4.  In the Publish a message page, for Subject, enter a subject line for your message, and for Message, enter a brief message.

5.  Choose Publish Message.

6.  Check your email to confirm that you received the message.

## Publish message by Python script

1. Edit the **publish_message.py** script, change topic_arn you created before
2. Run commnand to publish message:
    >
        Python3 publish_message.py
6.  Check your email to confirm that you received the message.
![Billing arlarm](https://dd.engineering/blog/aws-setting-up-a-billing-alarm/banner.png)
# Creating a Billing Alarm to Monitor AWS Charges
You can monitor your estimated AWS charges by using Amazon CloudWatch. When you enable the monitoring of estimated charges for your AWS account, the estimated charges are calculated and sent several times daily to CloudWatch as metric data.

The alarm triggers when your account billing exceeds the threshold you specify. It triggers only when actual billing exceeds the threshold. It doesn't use projections based on your usage so far in the month.

## Step 1: Enabling billing alerts

Before you can create an alarm for your estimated charges, you must enable billing alerts, so that you can monitor your estimated AWS charges and create an alarm using billing metric data.

>**Important**   
You must be signed in using account root user credentials or as an IAM user that has been given permission to view billing information

**To enable the monitoring of estimated charges**
1. Open the Billing and Cost Management console at 
[Billing Console](https://console.aws.amazon.com/billing/home?#/).
2. In the navigation pane, choose **Billing Preferences**.
3. Choose **Receive Billing Alerts**.
4. Choose **Save preferences**.

> After you enable billing alerts for the first time, it takes about 15 minutes before you can view billing data and set billing alarms.

## Step 2: Creating a Billing Alarm

> **Important**  
Before you can create a billing alarm, you must enable billing alerts in your account, or in the master/payer account if you are using consolidated billing.

After you've enabled billing alerts, you can create a billing alarm. In this scenario, you create an alarm that sends an email message when your estimated charges for AWS exceed a specified threshold.

**To create a billing alarm**
1. Open the [CloudWatch console](https://console.aws.amazon.com/cloudwatch/).
    >   If necessary, change the Region to US East (N. Virginia). Billing metric data is stored in this Region and represents worldwide charges.
2. In the navigation pane, choose **Alarms** > **Billing** > **Create Alarm**.
3. Choose **Select metric, Billing, Total Estimated Charge**.
    > If you don't see **Billing** or the **Total Estimated Charge** metric, you might need to enable billing alerts.
4. Select the checkbox next to **EstimatedCharges** and choose **Select metric**.
5. For **Whenever my total AWS charges for the month exceed**, specify the monetary amount (for example, 50) that must be exceeded to trigger the alarm and send an email notification. Then choose **Next**.
6. For **send a notification to**, do one of the following:
- Choose **Select an existing SNS topic** and then select the topic to notify under Send a notification to.
- Choose **Create a new topic** and then type a name for the new SNS topic and enter the email addresses that are to receive the notifications. Separate the email names with commas.
7. Choose **Next**
8. Enter the **Alarm Name**, Choose **Next**
9. Choose **Create Alarm**.

## Step 3: Check the alarm status
Now, check the status of the billing alarm that you just created.
1. Open the [CloudWatch console](https://console.aws.amazon.com/cloudwatch/).
2. In the navigation pane, choose **Alarms** > **All Alarm**.
3. Select the alarm name to show the alarm detail.

## Step 4: Edit a billing alarm
For example, you may want to increase the amount of money you spend with AWS each month from $50 to $200. You can edit your existing billing alarm and increase the monetary amount that must be exceeded before the alarm is triggered.
**To edit a billing alarm**
1. Open the [CloudWatch console](https://console.aws.amazon.com/cloudwatch/).
2. In the navigation pane, choose **Alarms** > **All Alarm**.
3. Select the check box next to the alarm and choose **Actions, Edit**.
4. For **Whenever my total AWS charges for the month exceed**, specify the new amount that must be exceeded to trigger the alarm and send an email notification.
5. Choose **Update alarm**.

## Step 5: Delete a billing arlarm
If you no longer need your billing alarm, you can delete it.  
**To delete a billing alarm**
1. Open the [CloudWatch console](https://console.aws.amazon.com/cloudwatch/).
2. In the navigation pane, choose **Alarms** > **All Alarm**.
3. Select the check box next to the alarm and choose **Actions, Delete**.
4. When prompted for confirmation, choose **Yes, Delete**.


## Reference documents:
- [https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-what-is.html](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-what-is.html)
- [https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)

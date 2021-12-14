# Creating a cloudwatch alarm for RDS 

1.  Open the[ CloudWatch console](https://console.aws.amazon.com/cloudwatch), and choose Alarms from the navigation pane.
2.  Choose Create alarm, and choose Select metric.
3.  From the All metrics tab, choose RDS.
4.  Choose Per-Database Metrics.
5.  Search for the FreeStorageSpace metric.
6.  For the instance that you want to monitor, choose the DB instance Identifier FreeStorageSpace metric.
7.  In the Conditions section, configure the threshold. For example, choose Lower/Equal, and then specify the threshold value.\
    Note: You must specify the value for the parameter in bytes. For example, 10 GB is 10737418240 bytes.
8.  Choose Next.
9.  From the Configure actions page, for the alarm state, choose in Alarm.
10. From Select an SNS topic, choose Create new topic.
11. Enter the topic name, for example, rds-storage-alarm.
12. For Email endpoints that will receive the notification, enter your email address.
13. Choose Create topic. This sends a confirmation email to the address that you specified.
14. Open the email notification that you received from AWS Notifications, and then choose Confirm subscription.
15. Return to the Configure actions page in the CloudWatch console.
16. Choose Next.
17. Enter a name and description for your alarm, and choose Next.
18. Review the preview of your metric, and choose Create alarm.
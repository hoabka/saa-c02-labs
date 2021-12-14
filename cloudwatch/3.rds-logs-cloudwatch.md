# Publishing MySQL logs to Amazon CloudWatch Logs
With CloudWatch Logs, you can perform real-time analysis of the log data, store the data in highly durable storage, and manage the data with the CloudWatch Logs Agent. AWS retains log data published to CloudWatch Logs for an indefinite time period unless you specify a retention period. 
## Configuring CloudWatch log integration
The error log is enabled by default. The following table summarizes the requirements for the other MySQL logs.

| Log | Requirement |
| --- | --- |
| Audit log | The DB instance must use a custom option group with the `MARIADB_AUDIT_PLUGIN` option. |
| General log | The DB instance must use a custom parameter group with the parameter setting `general_log = 1` to enable the general log. |
| Slow query log | The DB instance must use a custom parameter group with the parameter setting `slow_query_log = 1` to enable the slow query log. |
| Log output | The DB instance must use a custom parameter group with the parameter setting `log_output = FILE` to write logs to the file system and publish them to CloudWatch Logs. |

### To publish MySQL logs to CloudWatch Logs using the console

1.  Open the Amazon RDS console at <https://console.aws.amazon.com/rds/>.

2.  In the navigation pane, choose Databases, and then choose the DB instance that you want to modify.

3.  Choose Modify.

4.  In the Log exports section, choose the logs that you want to start publishing to CloudWatch Logs.

5.  Choose Continue, and then choose Modify DB Instance on the summary page.

for example, to stream slow logs to cloudwatch logs, change `slow_query_log` variable value to `1`

### View logs on cloudwatch
1.  Open the CloudWatch console at <https://console.aws.amazon.com/cloudwatch/>.

2.  In the navigation pane, choose Log groups.

3.  For Log Groups, choose the log group to view the streams.

4.  In the list of log groups, choose the name of the log group that you want to view.

5.  In the list of log streams, choose the name of the log stream that you want to view.

6.  To change how the log data is displayed, do one of the following:

    -   To expand a single log event, choose the arrow next to that log event.

    -   To expand all log events and view them as plain text, above the list of log events, choose Text.

    -   To filter the log events, enter the desired search filter in the search field. For more information, see [Creating metrics from log events using filters](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringLogData.html).

    -   To view log data for a specified date and time range, next to the search filter, choose the arrow next to the date and time. To specify a date and time range, choose Absolute. To choose a predefined number of minutes, hours, days, or weeks, choose Relative. You can also switch between UTC and local time zone.


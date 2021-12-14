# Creating a CloudWatch dashboard
To get started with CloudWatch dashboards, you must first create a dashboard. You can create multiple dashboards. There is no limit on the number of CloudWatch dashboards in your AWS account. All dashboards are global, not Region-specific.

**To create a dashboard using the console**
1.  Open the CloudWatch console at <https://console.aws.amazon.com/cloudwatch/>.

2.  In the navigation pane, choose Dashboards and then Create dashboard.

3.  In the Create new dashboard dialog box, enter a name for the dashboard and choose Create dashboard.

    If you use the name CloudWatch-Default, the dashboard appears on the overview on the CloudWatch home page. For more information, see [Getting started with Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/GettingStarted.html).

    If you use resource groups and name the dashboard CloudWatch-Default-*ResourceGroupName*, it appears on the CloudWatch home page when you focus on that resource group.

4.  Do one of the following in the Add to this dashboard dialog box:

    -   To add a graph to your dashboard, choose Line or Stacked area and choose Configure. In the Add metric graph dialog box, select the metrics to graph and choose Create widget. If a specific metric doesn't appear in the dialog box because it hasn't published data in more than 14 days, you can add it manually. For more information, see [Graph metrics manually on a CloudWatch dashboard](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/add_old_metrics_to_graph.html).

    -   To add a number displaying a metric to the dashboard, choose Number and then Configure. In the Add metric graph dialog box, select the metrics to graph and choose Create widget.

    -   To add a text block to your dashboard, choose Text and then Configure. In the New text widget dialog box, for Markdown, add and format your text using [Markdown](https://docs.aws.amazon.com/general/latest/gr/aws-markdown.html). Choose Create widget.

5.  Optionally, choose Add widget and repeat step 4 to add another widget to the dashboard. You can repeat this step multiple times.

6.  Choose Save dashboard.

** To view a cloudwatch dashboard**
1.  Open the CloudWatch console at <https://console.aws.amazon.com/cloudwatch/>.

2.  In the navigation pane, choose Dashboards.
3. In the Dashboards, choose the dashboard you want to view.

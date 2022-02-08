# Create a simple service by using AWS ECS
![ecs-fargate](https://blog.outwiththeold.info/assets/img/simple-api-iac/ecs-architecture.svg)

## Create a target group

1.  In the [Amazon EC2 console](https://console.aws.amazon.com/ec2/), in the navigation pane, choose Target Groups.
2.  Choose Create target group.
3.  For Target group name, enter a name.
4.  For Target type, choose Instance or IP.\
    >Important: If your service's task definition uses the awsvpc network mode (required for the AWS Fargate launch type), you must choose IP as the target type. This is because tasks that use the awsvpc network mode are associated with an elastic network interface. These tasks aren't associated with an Amazon Elastic Compute Cloud (Amazon EC2) instance.
5.  For VPC, choose the VPC that you want to attach to your target group.
6.  Choose Create.

## Associate your target group with your load balancer

1.  In the navigation pane of the [Amazon EC2 console](https://console.aws.amazon.com/ec2/), choose Load Balancers.
2.  Choose Create Load Balancer.
3.  For Application Load Balancer, choose Create.
4.  For Name, enter a name for your load balancer.
5.  In the Listeners section, for Load Balancer Protocol, choose HTTP or HTTPS.
6.  In the Availability Zones section, for VPC, choose your VPC.
7.  For Availability Zones, choose at least two subnet IDs.
8.  Choose Next: Configure Security Settings, and then choose Next: Configure Security Groups.
9.  In the Security Group ID column, choose the security group ID that you want to attach to the load balancer.
10. Choose Next: Configure Routing.
11. In the Target group section, for Target group, choose Existing target group.
12. For Name, choose the target group that you created previously in the Create a target group section.
13. Choose Next: Register Targets, Next: Review, Create.

## Create ECS cluster
1.  Open the [Amazon ECS console](https://console.aws.amazon.com/ecs/).
2.  In the navigation pane, choose Clusters, and then select **Create Cluster**.
3. In the **Select cluster template**, select **Networking only** to use AWS Fargate.
4. Hit **Next**, then **Create**.

## Create a Task Definitions
1.  Open the [Amazon ECS console](https://console.aws.amazon.com/ecs/).
2.  In the navigation pane, choose **Task Definitions**, then click **Create new Task Definition**.
3.  Select **Fargate** and **Next**
4.  Configure these parameters:
    -   Task definition name
    -   Operating system family: Linux
    -   Task memory (GB): 0.5GB
    -   Task CPU (vCPU): 0.25vCPU
5. Click to **Add container** and configure paremeters below:
    -   Container name: ecs-nginx
    -   Image: nginx
    -   Port mappings: 80
6. Click **Add**
7. Click **Create**

## Create an Amazon ECS service using the previous Application Load Balancer

1.  Open the [Amazon ECS console](https://console.aws.amazon.com/ecs/).
2.  In the navigation pane, choose Clusters, and then select your cluster.
3.  On the Services tab, choose Create.
4.  In the Configure service section, confirm that you have at least one [task definition created](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-task-definition.html).\
    Note: To use a load balancer, you must use containerPort in your task definition.
5.  For Launch type, choose **Fargate**.
6.  For Service name, enter a service name.
7.  For Number of tasks, enter the number of tasks.
8.  Choose Next step.
8. In the **VPC and security groups**, select VPC, subnets and security group you created before.
9.  In the Load balancing section, for Load balancer type, choose Application Load Balancer.
10. For Listener port, choose the application port that's used by your application (for example, 80:HTTP).
11. For Target group name, choose the target group that you created previously in the Create a target group section.
12. Choose Next step.
13. For Service Auto Scaling, choose Do adjust the service's desired count or Do not adjust the service's desired count based on the setup of your Amazon ECS service application.
14. Choose Next step, and then choose Create Service.
15. Choose View Service, and then choose the Tasks tab.
16. Choose the refresh icon, and then verify that your tasks are in the RUNNING state.

## View your service
Go to Load balancer DNS then you will be see the Nginx welcome page.




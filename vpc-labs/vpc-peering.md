# Create and accept VPC peering connections
To request a VPC peering connection with a VPC in your account, ensure that you have the IDs of the VPCs with which you are creating the VPC peering connection. You must both create and accept the VPC peering connection request yourself to activate it.

You can create a VPC peering connection with a VPC in the same Region, or a different Region.

>Important  
Ensure that your VPCs do not have overlapping IPv4 CIDR blocks. If they do, the status of the VPC peering connection immediately goes to `failed`. This limitation applies even if the VPCs have unique IPv6 CIDR blocks.

To create a VPC peering connection with a VPC in a different Region

1.  Open the Amazon VPC console at <https://console.aws.amazon.com/vpc/>.

2.  In the navigation pane, choose Peering Connections, Create Peering Connection.

3.  Configure the following information, and choose Create Peering Connection when you are done:

    -   Peering connection name tag: You can optionally name your VPC peering connection. Doing so creates a tag with a key of `Name` and a value that you specify.

    -   VPC (Requester): Select the requester VPC in your account with which to request the VPC peering connection.

    -   Account: Ensure My account is selected.

    -   Region: Choose Another region, select the Region in which the accepter VPC resides.

    -   VPC (Accepter): Enter the ID of the accepter VPC.

4.  In the confirmation dialog box, choose OK.

5.  In the Region selector, select the Region of the accepter VPC.

6.  In the navigation pane, choose Peering Connections. Select the VPC peering connection that you've created, and choose Actions, Accept Request.

7.  In the confirmation dialog, choose Yes, Accept. A second confirmation dialog displays; choose Modify my route tables now to go directly to the route tables page, or choose Close to do this later.

## Update your route tables for a VPC peering connection

Now that your VPC peering connection is active, you must add an entry to your VPC route tables to enable traffic to be directed between the peered VPCs.

1.  Open the Amazon VPC console at <https://console.aws.amazon.com/vpc/>.

2.  In the navigation pane, choose Route Tables.

3.  Select the check box next to the route table that's associated with the subnet in which your instance resides.

    Note

    If you do not have a route table associated with that subnet, select the main route table for the VPC, as the subnet then uses this route table by default.

4.  Choose Actions, Edit routes.

5.  Choose Add route.

6.  For Destination, enter the IPv4 address range to which the network traffic in the VPC peering connection must be directed. You can specify the entire IPv4 CIDR block of the peer VPC, a specific range, or an individual IPv4 address, such as the IP address of the instance with which to communicate. For example, if the CIDR block of the peer VPC is `10.0.0.0/16`, you can specify a portion `10.0.0.0/24`, or a specific IP address `10.0.0.7/32`.

7.  For Target, select the VPC peering connection, and then choose Save changes.
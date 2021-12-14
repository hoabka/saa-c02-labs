# Creating a read replica in a different AWS Region

With Amazon RDS, you can create a MariaDB, MySQL, Oracle, or PostgreSQL read replica in a different AWS Region from the source DB instance. Creating a cross-Region read replica isn't supported for SQL Server on Amazon RDS.

![
                Cross-Region read replica configuration
            ](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/images/read-replica-cross-region.png)

You create a read replica in a different AWS Region to do the following:

-   Improve your disaster recovery capabilities.

-   Scale read operations into an AWS Region closer to your users.

-   Make it easier to migrate from a data center in one AWS Region to a data center in another AWS Region.

**To create a read replica across AWS Regions with the console**

1.  Sign in to the AWS Management Console and open the Amazon RDS console at <https://console.aws.amazon.com/rds/>.

2.  In the navigation pane, choose Databases.

3.  Choose the MariaDB, MySQL, Oracle, or PostgreSQL DB instance that you want to use as the source for a read replica.

4.  For Actions, choose Create read replica.

5.  For DB instance identifier, enter a name for the read replica.

6.  Choose the Destination Region.

7.  Choose the instance specifications you want to use. We recommend that you use the same DB instance class and storage type for the read replica.

8.  To create an encrypted read replica in another AWS Region:

    1.  Choose Enable encryption.

    2.  For AWS KMS key, choose the AWS KMS key identifier of the KMS key in the destination AWS Region.

    >Note  
    To create an encrypted read replica, the source DB instance must be encrypted. To learn more about encrypting the source DB instance, see [Encrypting Amazon RDS resources](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html).

9.  Choose other options, such as storage autoscaling.

10. Choose Create read replica.
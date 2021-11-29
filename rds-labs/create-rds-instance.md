# Creating an Amazon RDS DB instance
**To create a DB instance**

1.  Sign in to the AWS Management Console and open the Amazon RDS console at <https://console.aws.amazon.com/rds/>.

2.  In the upper-right corner of the Amazon RDS console, choose the AWS Region in which you want to create the DB instance.

3.  In the navigation pane, choose Databases.

4.  Choose Create database.

5.  In Choose a database creation method, select Standard Create.

6.  In Engine options, choose the engine type: MariaDB, Microsoft SQL Server, MySQL, Oracle, or PostgreSQL. Microsoft SQL Server is shown here.

    ![
    						Engine selection
    					](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/images/SQLSvr-Launch01.png)

7.  For Edition, if you're using Oracle or SQL Server choose the DB engine edition that you want to use.

    MySQL has only one option for the edition, and MariaDB and PostgreSQL have none.

8.  For Version, choose the engine version.

9.  In Templates, choose the template that matches your use case. If you choose Production, the following are preselected in a later step:

    -   Multi-AZ failover option

    -   Provisioned IOPS storage option

    -   Enable deletion protection option

    We recommend these features for any production environment.

    Note

    Template choices vary by edition.

10. To enter your master password, do the following:

    1.  In the Settings section, open Credential Settings.

    2.  If you want to specify a password, clear the Auto generate a password check box if it is selected.

    3.  (Optional) Change the Master username value.

    4.  Enter the same password in Master password and Confirm password.

11. For the remaining sections, specify your DB instance settings. For information about each setting, see [Settings for DB instances](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateDBInstance.html#USER_CreateDBInstance.Settings).

12. Choose Create database.

    If you chose to use an automatically generated password, the View credential details button appears on the Databases page.

    To view the master user name and password for the DB instance, choose View credential details.

    ![
    						Master user credentials after automatic password generation.
    					](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/images/easy-create-credentials.png)

    To connect to the DB instance as the master user, use the user name and password that appear.

    Important

    You can't view the master user password again. If you don't record it, you might have to change it. If you need to change the master user password after the DB instance is available, modify the DB instance to do so. For more information about modifying a DB instance, see [Modifying an Amazon RDS DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html).

13. For Databases, choose the name of the new DB instance.

    On the RDS console, the details for the new DB instance appear. The DB instance has a status of Creating until the DB instance is created and ready for use. When the state changes to Available, you can connect to the DB instance. Depending on the DB instance class and storage allocated, it can take several minutes for the new instance to be available.

    ![
    						My DB instances details
    					](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/images/SQLSvr-Launch05.png)
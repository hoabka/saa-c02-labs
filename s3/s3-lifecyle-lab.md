# Managing your storage lifecycle
To manage your objects so that they are stored cost effectively throughout their lifecycle, configure their *Amazon S3 Lifecycle*. An *S3 Lifecycle configuration* is a set of rules that define actions that Amazon S3 applies to a group of objects. There are two types of actions:

-   Transition actions -- These actions define when objects transition to another storage class. For example, you might choose to transition objects to the S3 Standard-IA storage class 30 days after creating them, or archive objects to the S3 Glacier Flexible Retrieval storage class one year after creating them. For more information, see [Using Amazon S3 storage classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html).

    There are costs associated with lifecycle transition requests. For pricing information, see [Amazon S3 pricing](https://aws.amazon.com/s3/pricing/).

-   Expiration actions -- These actions define when objects expire. Amazon S3 deletes expired objects on your behalf.

    Lifecycle expiration costs depend on when you choose to expire objects. For more information, see [Expiring objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-expire-general-considerations.html).


**To create a lifecycle rule for a S3 Bucket**

In this tutorial, we will create a lifecycle rule to move objects from standard class to One Zone-IA class after 30 days to save the storage cost.


1.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  In the Buckets list, choose the name of the bucket that you want to enable static website hosting for.
3. In the **Management** tab, **Lifecycle rules** session, click to **Create lifecyle rule**
4. In the **Lifecycle rule configuration** console, enter these values:
- Lifecycle rule name: Enter a name of rule
- Prefix: *.jpg for example
- Lifecycle rule actions: Move current versions of objects between storage classes
- Transition current versions of objects between storage classes:  
    - Choose storage class transitions: One Zone-IA
    - Days after object creation: 30

5. Click to **Create rule**

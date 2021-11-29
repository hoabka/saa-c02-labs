![AWS S3](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2eA6JllzGpUqb6zvit059PhvAEMM7m3Ebojg1S_btdCxjU39dy7JmGdtzudrMhYFjJ7Q&usqp=CAU)
# Creating a S3 bucket
To upload your data to Amazon S3, you must first create an Amazon S3 bucket in one of the AWS Regions. When you create a bucket, you must choose a bucket name and Region. You can optionally choose other storage management options for the bucket. After you create a bucket, you cannot change the bucket name or Region. For information about naming buckets, see [Bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).

**To create a S3 bucket using console**
1.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  Choose **Create bucket**.

    The **Create bucket** wizard opens.

3.  In **Bucket name**, enter a DNS-compliant name for your bucket.

    The bucket name must:

    -   Be unique across all of Amazon S3.

    -   Be between 3 and 63  characters long.

    -   Not contain uppercase characters.

    -   Start with a lowercase letter or number.

    After you create the bucket, you can't change its name. For information about naming buckets, see [Bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).

    >**Important**  
    >Avoid including sensitive information, such as account numbers, in the bucket name. The bucket name is visible in the URLs that point to the objects in the bucket.

4.  In **Region**, choose the AWS Region where you want the bucket to reside.

    >Choose a Region close to you to minimize latency and costs and address regulatory requirements. Objects stored in a Region never leave that Region unless you explicitly transfer them to another Region. For a list of Amazon S3 AWS Regions, see [AWS service endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the *Amazon Web Services General Reference*.

5.  In **Bucket settings** for Block Public Access, choose the Block Public Access settings that you want to apply to the bucket.

    We recommend that you keep all settings enabled unless you know that you need to turn off one or more of them for your use case, such as to host a public website. Block Public Access settings that you enable for the bucket are also enabled for all access points that you create on the bucket. For more information about blocking public access, see [Blocking public access to your Amazon S3 storage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html).

6.  (Optional) If you want to enable S3 Object Lock, do the following:

    1.  Choose **Advanced settings**, and read the message that appears.

        >**Important**  
        You can only enable S3 Object Lock for a bucket when you create it. If you enable Object Lock for the bucket, you can't disable it later. Enabling Object Lock also enables versioning for the bucket. After you enable Object Lock for the bucket, you must configure the Object Lock settings before any objects in the bucket will be protected. For more information about configuring protection for objects, see [Using S3 Object Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html).

    2.  If you want to enable Object Lock, enter `enable` in the text box and choose **Confirm**.

    For more information about the S3 Object Lock feature, see [Using S3 Object Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html).

    >**Note** 
    To create an Object Lock enabled bucket, you must have the following permissions: s3:CreateBucket, s3:PutBucketVersioning and s3:PutBucketObjectLockConfiguration.

7.  Choose **Create bucket**.
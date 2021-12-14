# Adding a bucket policy
A bucket policy is a resource-based AWS Identity and Access Management (IAM) policy. You add a bucket policy to a bucket to grant other AWS accounts or IAM users access permissions for the bucket and the objects in it. Object permissions apply only to the objects that the bucket owner creates. For more information about bucket policies, see [Overview of managing access](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-overview.html).

## To create or edit a bucket policy
1.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  In the **Buckets list**, choose the name of the bucket that you want to create a bucket policy for or whose bucket policy you want to edit.

3.  Choose **Permissions**.
4. In the **Block public access (bucket settings)**, click edit and uncheck the **Block all public access**

5.  In the **Bucket policy editor** text box, type or copy and paste a new bucket policy, or edit an existing policy. The bucket policy is a JSON file. The text you type in the editor must be valid JSON.


6.  Under **Bucket policy**, choose **Edit**.

7.  In the **Policy** text field, type or copy and paste a new bucket policy, or edit an existing policy. The bucket policy is a JSON file. The text you type in the editor must be valid JSON.

    >
        {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Statement1",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::bucketname/folder/*"
            }
        ]
        }


8.  Choose **Save changes**.


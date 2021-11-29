# Adding a bucket policy
A bucket policy is a resource-based AWS Identity and Access Management (IAM) policy. You add a bucket policy to a bucket to grant other AWS accounts or IAM users access permissions for the bucket and the objects in it. Object permissions apply only to the objects that the bucket owner creates. For more information about bucket policies, see [Overview of managing access](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-overview.html).

## To create or edit a bucket policy
1.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  In the **Buckets list**, choose the name of the bucket that you want to create a bucket policy for or whose bucket policy you want to edit.

3.  Choose **Permissions**.

4.  In the **Bucket policy editor** text box, type or copy and paste a new bucket policy, or edit an existing policy. The bucket policy is a JSON file. The text you type in the editor must be valid JSON.

5.  (Optional) Choose **Policy generator** to open the AWS Policy Generator in a new window.

    1.  On the policy generator page, select **S3 Bucket Policy** from the **Select Type of Policy** menu.

    2.  Add one or more statements by populating the fields presented, and then choose **Generate Policy**.

    3.  Copy the generated policy text, and return to the **Edit bucket policy** page in the Amazon S3 console.

6.  Under **Bucket policy**, choose **Edit**.

7.  In the **Policy** text field, type or copy and paste a new bucket policy, or edit an existing policy. The bucket policy is a JSON file. The text you type in the editor must be valid JSON.

    >**Note**  
    For convenience, the console displays the Amazon Resource Name (ARN) of the current bucket above the **Policy** text field. You can copy this ARN for use in the policy. For more information about ARNs, see [Amazon Resource Names (ARNs) and AWS Service Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.

8.  (Optional) Preview how your new policy affects public and cross-account access to your resource. Before you save your policy, you can check whether it introduces new IAM Access Analyzer findings or resolves existing findings. If you don't see an active analyzer, [create an account analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#access-analyzer-enabling) in IAM Access Analyzer. For more information, see [Preview access](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-access-preview.html) in the *IAM User Guide*.

9.  Choose **Save changes**.

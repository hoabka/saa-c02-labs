# Hosting a static website using Amazon S3
You can use Amazon S3 to host a static website. On a static website, individual webpages include static content. They might also contain client-side scripts.


## Website endpoints
Depending on your Region, your Amazon S3 website endpoint follows one of these two formats.

-   s3-website dash (-) Region ‐ `http://`bucket-name`.s3-website-`Region`.amazonaws.com`

-   s3-website dot (.) Region ‐ `http://`bucket-name`.s3-website.`Region`.amazonaws.com`

These URLs return the default index document that you configure for the website. For a complete list of Amazon S3 website endpoints, see [Amazon S3 Website Endpoints](https://docs.aws.amazon.com/general/latest/gr/s3.html#s3_website_region_endpoints).

## Enabling website hosting
When you configure a bucket as a static website, you must enable static website hosting, configure an index document, and set permissions.
1.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  In the Buckets list, choose the name of the bucket that you want to enable static website hosting for.

3.  Choose Properties.

4.  Under Static website hosting, choose Edit.

5.  Choose Use this bucket to host a website.

6.  Under Static website hosting, choose Enable.

7.  In Index document, enter the file name of the index document, typically `index.html`.

    The index document name is case sensitive and must exactly match the file name of the HTML index document that you plan to upload to your S3 bucket. When you configure a bucket for website hosting, you must specify an index document. Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders. For more information, see [Configuring an index document](https://docs.aws.amazon.com/AmazonS3/latest/userguide/IndexDocumentSupport.html).

8.  To provide your own custom error document for 4XX class errors, in Error document, enter the custom error document file name.

    The error document name is case sensitive and must exactly match the file name of the HTML error document that you plan to upload to your S3 bucket. If you don't specify a custom error document and an error occurs, Amazon S3 returns a default HTML error document. For more information, see [Configuring a custom error document](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CustomErrorDocSupport.html).

9.  (Optional) If you want to specify advanced redirection rules, in Redirection rules, enter XML to describe the rules.

    For example, you can conditionally route requests according to specific object key names or prefixes in the request. For more information, see [Configure redirection rules to use advanced conditional redirects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-page-redirect.html#advanced-conditional-redirects).

10. Choose Save changes.

    Amazon S3 enables static website hosting for your bucket. At the bottom of the page, under Static website hosting, you see the website endpoint for your bucket.

11. Under Static website hosting, note the Endpoint.

    The Endpoint is the Amazon S3 website endpoint for your bucket. After you finish configuring your bucket as a static website, you can use this endpoint to test your website.

## Configuring an index document
When you enable website hosting, you must also configure and upload an index document. An *index document* is a webpage that Amazon S3 returns when a request is made to the root of a website or any subfolder. For example, if a user enters `http://www.example.com` in the browser, the user is not requesting any specific page. In that case, Amazon S3 serves up the index document, which is sometimes referred to as the *default page*.

When you enable static website hosting for your bucket, you enter the name of the index document (for example, `index.html`). After you enable static website hosting for your bucket, you upload an HTML file with the index document name to your bucket.

**To configure the index document**
1.  Create an `index.html` file.

    If you don't have an `index.html` file, you can use the following HTML to create one:

>  
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title>My Website Home Page</title>
    </head>
    <body>
      <h1>Welcome to my website</h1>
      <p>Now hosted on Amazon S3!</p>
    </body>
    </html>

2.  Save the index file locally.

    The index document file name must exactly match the index document name that you enter in the Static website hosting dialog box. The index document name is case sensitive. For example, if you enter `index.html` for the Index document name in the Static website hosting dialog box, your index document file name must also be `index.html` and not `Index.html`.

3.  Sign in to the AWS Management Console and open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

4.  In the Buckets list, choose the name of the bucket that you want to use to host a static website.

5.  Enable static website hosting for your bucket, and enter the exact name of your index document (for example, `index.html`). For more information, see [Enabling website hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/EnableWebsiteHosting.html).

    After enabling static website hosting, proceed to step 6.

6.  To upload the index document to your bucket, do one of the following:

    -   Drag and drop the index file into the console bucket listing.

    -   Choose Upload, and follow the prompts to choose and upload the index file.

    For step-by-step instructions, see [Uploading objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/upload-objects.html).

7.  (Optional) Upload other website content to your bucket.

## Setting permissions for website access
When you configure a bucket as a static website, if you want your website to be public, you can grant public read access. To make your bucket publicly readable, you must disable block public access settings for the bucket and write a bucket policy that grants public read access. If your bucket contains objects that are not owned by the bucket owner, you might also need to add an object access control list (ACL) that grants everyone read access.

>Note  
On the website endpoint, if a user requests an object that doesn't exist, Amazon S3 returns HTTP response code `404 (Not Found)`. If the object exists but you haven't granted read permission on it, the website endpoint returns HTTP response code `403 (Access Denied)`. The user can use the response code to infer whether a specific object exists. If you don't want this behavior, you should not enable website support for your bucket.

**Step 1: Edit S3 Block Public Access settings**
1.  Open the Amazon S3 console at <https://console.aws.amazon.com/s3/>.

2.  Choose the name of the bucket that you have configured as a static website.

3.  Choose Permissions.

4.  Under Block public access (bucket settings), choose Edit.

5.  Clear Block *all* public access, and choose Save changes.

>Warning  
    Before you complete this step, review [Blocking public access to your Amazon S3 storage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html) to ensure you understand and accept the risks involved with allowing public access. When you turn off block public access settings to make your bucket public, anyone on the internet can access your bucket. We recommend that you block all public access to your buckets.

![aws](https://docs.aws.amazon.com/AmazonS3/latest/userguide/images/edit-public-access-clear.png)

Amazon S3 turns off Block Public Access settings for your bucket. To create a public, static website, you might also have to [edit the Block Public Access settings](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/block-public-access-account.html) for your account before adding a bucket policy. If account settings for Block Public Access are currently turned on, you see a note under Block public access (bucket settings).

**Step 2: Add a bucket policy**
To make the objects in your bucket publicly readable, you must write a bucket policy that grants everyone s3:GetObject permission.

After you edit S3 Block Public Access settings, you can add a bucket policy to grant public read access to your bucket. When you grant public read access, anyone on the internet can access your bucket.

>Important  
The following policy is an example only and allows full access to the contents of your bucket. Before you proceed with this step, review How can I secure the files in my Amazon S3 bucket? to ensure that you understand the best practices for securing the files in your S3 bucket and risks involved in granting public access.

1.  Under Buckets, choose the name of your bucket.

2.  Choose Permissions.

3.  Under Bucket Policy, choose Edit.

4.  To grant public read access for your website, copy the following bucket policy, and paste it in the Bucket policy editor.

        `{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "s3:GetObject"
                ],
                "Resource": [
                    "arn:aws:s3:::`Bucket-Name`/*"
                ]
            }
        ]
    }`

5.  Update the `Resource` to your bucket name.

    In the preceding example bucket policy, `Bucket-Name` is a placeholder for the bucket name. To use this bucket policy with your own bucket, you must update this name to match your bucket name.

6.  Choose Save changes.

    A message appears indicating that the bucket policy has been successfully added.

    If you see an error that says `Policy has invalid resource`, confirm that the bucket name in the bucket policy matches your bucket name. For information about adding a bucket policy, see [How do I add an S3 bucket policy?](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/add-bucket-policy.html)
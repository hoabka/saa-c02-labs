# Deploy a Static Website on S3 using AWS CodePipeline

You configure a pipeline that continuously delivers files using Amazon S3 as the deployment action provider in your deployment stage. The completed pipeline detects changes when you make a change to the source files in your source repository. The pipeline then uses Amazon S3 to deploy the files to your bucket. Each time you modify or add your website files in your source location, the deployment creates the website with your latest files.

#### Create a CodeCommit Repository from the Management Console
1. Navigate to CodeCommit.
2. Under Repositories, click **Create repository.**
3. In Repository name, enter **webapp-static.**
4. Under Tags, click **Add**.
5. Set the following values:
	- Key: **CreatedBy**
	- Value: Your name
6. Click **Create**.
7. Scroll to the bottom of the page and click **Add file > Upload file**.
8. Click Choose file and select the **index.html** file downloaded from GitHub.
9. In Commit changes to master, set the following values:
	- Author name: Your name
	- Email address: Your email
	- Commit message: Landing page
10. Click Commit changes.
11. Click Repositories.
12. Click **webapp-static** to open the repository page.
13. Click Add file > Upload file.
14. Click Choose file and select the **graphic.jpg** file downloaded from GitHub.
15. In the Commit changes to master section, set the following values:
	- Author name: Your name
	- Email address: Your email
	- Commit message: Photo
16. Click **Commit changes.**


#### Create an S3 Bucket and Configure It To Host a Static Website

**Create an S3 Bucket**
1. Navigate to S3.
2. Click **Create bucket.**
3. Set the following values:
	- Bucket name: Unique bucket name
	- Region: **US East (N. Virginia)** or **us-east-2 (Ohio)**
4. Click **Next > Next.**
5. Deselect **Block all public access.**
6. Select **I acknowledge that the current settings might result in this bucket and the objects within becoming public.**
7. Click **Add tag**.
8. Set the following values:
	- Key: **CreatedBy**
	- Value: Your name
9. Leave the rest as their defaults and click **Create bucket.**

#### Enable Static Website Hosting

1. Click the newly created bucket to open it and select the **Properties tab.**
2. Scroll to Static website hosting at the bottom and click **Edit**.
3. In Static website hosting, select **Enable**.
4. Set the following values:
	- Index document: **Index.html**
	- Error document: **error.html**
5. Click **Save changes.**

#### Create an S3 Bucket Policy

1. Select the **Permissions** tab.
2. Scroll down to Bucket policy and click **Edit**.
3. Add the policy as below

```hcl
{
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
                "arn:aws:s3:::Bucket-Name/*"
            ]
        }
    ]
}
```

Click **Save changes.**

#### Create a Pipeline in AWS CodePipeline That Deploys a Static Website

1. Navigate to CodePipeline.
2. Under Pipelines click **Create pipeline.**
3. In Pipeline name, enter **webapp-static-pipeline** and click **Next**.
4. On the Source page, set the following values:
	- Source provider: **AWS CodeCommit**
	- Repository name: **webapp-static**
	- Branch name: **main**
5. In Change detection options, select **AWS CodePipeline** and click **Next**.
6. Click **Skip build stage > Skip.**
7. In Deploy on the next page, select **Amazon S3** as the deploy provider.
8. Set the following values:
	- Region: **US East (N. Virginia)**
	- Bucket: Your bucket name
9. Click **Extract file before deploy.**
10. Leave the rest as their defaults and click **Next**.
11. Click **Create pipeline.**
12. Once the deploy stage completes, click the Amazon S3 URL under Deploy to verify deployment.
13. Select the Properties tab and scroll down to **Static website hosting** at the bottom of the page.
14. Click the bucket website endpoint URL to view the static website.

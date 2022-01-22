# Build a Serverless Web Application

## Create a Lambda function for backend

1.  In a new browser tab, log into the [AWS Lambda Console.](https://console.aws.amazon.com/lambda/)
2.  Make sure you note what region you are creating your function in. You can see this at the very top of the page, next to your account name.
3.  Click on the orange "Create Function" button.
4.  Under "Function Name" type in *HelloWorldFunction*.
5.  Select Python 3.8 from the runtime drop-down.

![Full Stack tutorial CreateFunction Python](https://d1.awsstatic.com/webteam/getting_started/GSRC%202020%20updates/Full%20Stack%20tutorial%20CreateFunction%20Python.b97e9a953c622219acb51ee9def35470aa9d9167.png "Full Stack tutorial CreateFunction Python")

6\. Click on the orange "Create Function" button.

7\. You should see a green box at the top of your screen with the following message "Successfully created the function."

8\. Replace the code under "Function Code" with the following:

    
    # import the JSON utility package since we will be working with a JSON object
    import json
    # define the handler function that the Lambda service will use an entry point
    def lambda_handler(event, context):
        name = event['firstName'] +' '+ event['lastName']
        # return a properly formatted JSON object
        return {
        'statsusCode': 200,
        'body': json.dumps('Hello from Lambda, ' + name)
        }
    

9\. Click the orange "Save" button at the top of your screen.

10\. Let's test our new function. Click on "Select a test event" at the top of your screen.

11\. From that drop-down menu click on "Configure test events."

12\. Under "Event Name" type *HelloWorldTestEvent*.

13\. Copy and paste the following JSON object to replace the default one:

    {
    "firstName": "Ada",
    "lastName": "Lovelace"
    }


14\. Click the orange "Create" button a the bottom of the page.

**To test the function**
1.  Click the grey "Test" button at the top of the page.
2.  You should see a light green box at the top of the page with the following text: "Execution result: succeeded." You can click on "details" to see the event the function returned.
3.  Well done! You now have a working Lambda function.

## Link a Serverless Function to Api Gateway
In this session, we will use Amazon API Gateway to create a RESTful API that will allow us to make calls to our Lambda function from a web client (typically refers to a user's web browser).

### Create a New REST API
1.  Log into the [API Gateway Console](https://console.aws.amazon.com/apigateway/main/).
2.  Click the orange "Create API" button.
3.  Find the REST API box and click the orange "Build" button in it.
4.  Under "Choose the protocol," select REST.

5.  Under "Create new API," select New API.

6.  In the "API name" field type in *HelloWorldAPI*.
7.  Select "Edge optimized" in the "Endpoint Type" drop-down (Note: Edge optimized endpoints is best for geographically distributed clients. This makes it a good choice for public services being accessed from the Internet. Regional endpoints are typically used for APIs that are accessed primarily from within the same AWS Region.)
8.  Click the blue "Create API" button. Your settings should look like the following screenshot:

    ![Full Stack tutorial API settings](https://d1.awsstatic.com/webteam/getting_started/GSRC%202020%20updates/Full%20Stack%20tutorial%20API%20settings.00fc97f8ce54af56f304927323b49a4247ac2299.png "Full Stack tutorial API settings")


### Create a New Resource Method
1.  In the left nav, click on "Resources" under your HelloWorld API.
2.  With the "/" resource selected, click "Create Method" from the Action drop-down menu.
3.  Select POST from the new drop-down that appears, then click on the checkmark.
4.  Select Lambda Function for the integration type.
5.  Type in *HelloWorldFunction* into the "Function" field.
6.  Click the blue "Save" button.
7.  You should see a message letting you know you are giving the API you are creating permission to call your Lambda function. Click the "OK" button.
8.  With the newly created POST method selected, select "Enable CORS" from the Action drop-down menu.
9.  Leave the POST checkbox selected and click the blue "Enable CORS and replace existing CORS headers" button.

    ![Full Stack tutorial EnableCORS](https://d1.awsstatic.com/webteam/getting_started/GSRC%202020%20updates/Full%20Stack%20tutorial%20EnableCORS.5bd0a1c5540ba714abe44a6ffa0c80a3dd58ce16.png "Full Stack tutorial EnableCORS")

10. You should see a message asking you to confirm method changes. Click the blue "Yes, replace existing values" button.

    ![Full Stack tutorial ConfirmMethodChanges](https://d1.awsstatic.com/webteam/getting_started/GSRC%202020%20updates/Full%20Stack%20tutorial%20ConfirmMethodChanges.06ab437c86819e780eacc2bb2d5847d8f6274648.png "Full Stack tutorial ConfirmMethodChanges")  

### Deploy API
1.  In the "Actions" drop-down list select "Deploy API."
2.  Select "[New Stage]" in the "Deployment stage" drop-down list.
3.  Enter *dev* for the "Stage Name."
4.  Choose "Deploy."
5.  Copy and save the URL next to "Invoke URL"

### Validate API
1.  On the the left nav, click on "Resources."
2.  The methods for our API will now be listed on the right. Click on "POST."
3.  Click on the small blue lightning bolt.
4.  Paste the following into the "Request Body" field:

```
{
    "firstName":"Grace",
    "lastName":"Hopper"
}
```

5. Click the blue "Test" button.

6. On the right side, you should see a response with Code 200.
## Add Interactivity to Your Web App

In this session, we will update the static website we created in Module One to invoke the REST API we created in Module Three. This will add the ability to display text based on what you input.
1. file you created in Module One.
2. Make sure you add your API Invoke URL on Line 41 (from Module Three). NOTE: If you do not have your API's URL, you can get it from the [API Gateway Console](https://console.aws.amazon.com/apigateway/main/) by clicking on your API and then on "stages."

3. Save the file.

4. Upload to S3 Static web bucket.

### Test the Web App
1.  Click on the S3 Static web URL .
3.  Fill in your name (or whatever you prefer) and click the "Call API" button.
4.  You should see a message that starts with "Hello from Lambda" followed by the text you filled in.

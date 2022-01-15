# Creating a simple queue using Amazon SQS
Step 1: Create a queue
----------------------

The first and most common Amazon SQS task is creating queues. This procedure shows how to create and configure a FIFO queue.

1.  Open the Amazon SQS console at <https://console.aws.amazon.com/sqs/>.

2.  Choose Create queue.

3.  On the Create queue page, specify the correct region.

4.  The Standard queue type is selected by default. Choose FIFO.

    You can't change the queue type after you create a queue.

5.  Enter a Name for your queue. The name of a FIFO queue must end with the `.fifo` suffix.
5. Enable **Content-based deduplication** option.

6.  To create your queue with the default parameters, scroll to the bottom and choose Create Queue. Amazon SQS creates the queue and displays the queue's Details page.

    Amazon SQS propagates information about the new queue across the system. Because Amazon SQS is a distributed system, you may experience a slight delay before the queue is displayed on the Queues page.


Step 2: Configure AWS CLI credential and Install boto3
----------------------
1. Download IAM User credential 
2. Configure AWS CLI by run following commands:  
    >
         aws configure  
         AWS Access Key ID: Access  ID
         AWS Secret Access Key: Secret Access Key
         Default region name: Region you are In
3. Install boto3
    >       
        pip3 install boto3

Step 2: Send a message
----------------------

After you create your queue, you can send a message to it.

1. Change the queue name in the **send_message.py** script in line 10
2. Run script to send messagese to the queue:
    >  
        python3 send_message.py

3. Output will return MessageID like `d4f3665f-9408-49b9-bde1-5170e714e6d0`


Step 3: Receive and delete your message
---------------------------------------

After you send a message to a queue, you can retrieve the message from the queue. 

1.  Change the queue name in the **get_message.py** script in line 7

2.  Run script to get messagese from the queue:
    >
        python3 get_message.py
3. Output will be return the message like `Hello, message number 6`

Step 4: Delete your queue
-------------------------

1.  From the queue list, select the queue that you have created.

2.  From the Queues page, select the queue to delete.

3.  Choose Delete queue.

    The console displays the Delete queue dialog box.

4.  In the Delete queue dialog box, confirm the deletion by entering `delete`.

5.  Choose Delete.

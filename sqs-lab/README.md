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

6.  To create your queue with the default parameters, scroll to the bottom and choose Create Queue. Amazon SQS creates the queue and displays the queue's Details page.

    Amazon SQS propagates information about the new queue across the system. Because Amazon SQS is a distributed system, you may experience a slight delay before the queue is displayed on the Queues page.

Step 2: Send a message
----------------------

After you create your queue, you can send a message to it.

1.  From the left navigation pane, choose Queues. From the queue list, select the queue that you created.

2.  From Actions, choose Send and receive messages.

    ![](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/images/sqs-tutorials-sending-message-to-queue-send-a-message.png)

    The console displays the Send and receive messages page.

3.  Enter text in the Message body

4.  Enter a Message group id for the queue. For more information, see [FIFO delivery logic](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-understanding-logic.html).

5.  (Optional) Enter a Message deduplication id. If you enable content-based deduplication, the message deduplication ID is not required. For more information, see [FIFO delivery logic](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-understanding-logic.html).

6.  Choose Send message.

    Your message is sent and the console displays a success message. Choose View details to display information about the sent message.

    ![](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/images/sqs-tutorials-sending-message-success.png)

Step 3: Receive and delete your message
---------------------------------------

After you send a message to a queue, you can retrieve the message from the queue. When you request messages from a queue, you can't specify which message to retrieve. Instead, you specify the maximum number of messages (up to 10) that you want to retrieve.

1.  From the Queues page, select a queue.

2.  From Queue Actions, select Send and receive messages.

    ![](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/images/sqs-tutorials-sending-message-to-queue-send-a-message.png)

    The console displays the Send and receive messages page.

3.  Choose Poll for messages.

    Amazon SQS begins to poll servers to find messages in the queue. The progress bar on the right side of the Receive messages section displays the polling duration.

    The Messages section displays a list of the received messages. For each message, the list displays the message ID, sent date, size, and receive count.

4.  To delete messages, select the messages that you want to delete and then choose Delete.

5.  In the Delete Messages dialog box, choose Delete.

Step 4: Delete your queue
-------------------------

1.  From the queue list, select the queue that you have created.

2.  From the Queues page, select the queue to delete.

3.  Choose Delete queue.

    The console displays the Delete queue dialog box.

4.  In the Delete queue dialog box, confirm the deletion by entering `delete`.

5.  Choose Delete.

6.
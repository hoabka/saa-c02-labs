import boto3
import string
import random
# Create SQS client


# Get the service resource
sqs = boto3.resource('sqs')
# Get the queue
queue = sqs.get_queue_by_name(QueueName='test.fifo')
for i in range(10):
# Send message to SQS queue

    response = queue.send_message(
        MessageBody="Hello, This is message number %i" % (i),
        MessageGroupId='messageGroup'
    )
    print(response.get('MessageId'))



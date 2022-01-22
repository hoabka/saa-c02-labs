import boto3
import time
# Get the service resource
sqs = boto3.resource('sqs')

# Get the queue
queue = sqs.get_queue_by_name(QueueName='test.fifo')

# Process messages by printing out body
for message in queue.receive_messages():
    # Print out the body of the message
    print('Hello, {0}'.format(message.body))
    #time.sleep(5)
    # Let the queue know that the message is processed
    message.delete()

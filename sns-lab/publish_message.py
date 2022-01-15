import boto3 

sns = boto3.client('sns')
sns.publish(TopicArn=topic_arn, 
            Message="Hello", 
            Subject="Welcome to SAA course!")
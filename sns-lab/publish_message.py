import boto3 

sns = boto3.client('sns')
sns.publish(TopicArn="arn:aws:sns:us-east-1:992728521074:test-sns", 
            Message="Hello from python", 
            Subject="Welcome to SAA course!")

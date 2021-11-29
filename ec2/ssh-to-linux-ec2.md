# Connect to your Linux instance using an SSH client
Use the following procedure to connect to your Linux instance using an SSH client. If you receive an error while attempting to connect to your instance, see [Troubleshoot connecting to your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html).

To connect to your instance using SSH

1.  In a terminal window, use the ssh command to connect to the instance. You specify the path and file name of the private key (`.pem`), the user name for your instance, and the public DNS name or IPv6 address for your instance. For more information about how to find the private key, the user name for your instance, and the DNS name or IPv6 address for an instance, see [Locate the private key and set the permissions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html#connection-prereqs-private-key) and [Get information about your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html#connection-prereqs-get-info-about-instance). To connect to your instance, use one of the following commands.

    -   (Public DNS) To connect using your instance's public DNS name, enter the following command.

        `ssh -i `/path/my-key-pair`.pem `my-instance-user-name`@`my-instance-public-dns-name``

    -   (IPv6) Alternatively, if your instance has an IPv6 address, to connect using your instance's IPv6 address, enter the following command.

        `ssh -i `/path/my-key-pair`.pem `my-instance-user-name`@`my-instance-IPv6-address``

    You see a response like the following:  
`The authenticity of host 'ec2-198-51-100-1.compute-1.amazonaws.com (198-51-100-1)' can't be established.
    ECDSA key fingerprint is l4UB/neBad9tvkgJf1QZWxheQmR59WgrgzEimCG6kZY.
    Are you sure you want to continue connecting (yes/no)?`

2.  (Optional) Verify that the fingerprint in the security alert matches the fingerprint that you previously obtained in [(Optional) Get the instance fingerprint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html#connection-prereqs-fingerprint). If these fingerprints don't match, someone might be attempting a "man-in-the-middle" attack. If they match, continue to the next step.

3.  Enter `yes`.

    You see a response like the following:

    `Warning: Permanently added 'ec2-198-51-100-1.compute-1.amazonaws.com' (ECDSA) to the list of known hosts.`

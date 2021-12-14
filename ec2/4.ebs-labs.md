# EBS labs
## Create an Amazon EBS volume
You can create an Amazon EBS volume and then attach it to any EC2 instance in the same Availability Zone. 

**To create an empty EBS volume using the console**
1.  Open the Amazon EC2 console at <https://console.aws.amazon.com/ec2/>.

2.  In the navigation pane, choose Volumes.

3.  Choose Create volume.

4.  For Volume type, choose the type of volume to create. For more information, see [Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html).

5.  For Size, enter the size of the volume, in GiB. For more information, see [Constraints on the size and configuration of an EBS volume](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/volume_constraints.html).

6.  (`io1`, `io2`, and `gp3` only) For IOPS, enter the maximum number of input/output operations per second (IOPS) that the volume should provide.

7.  (`gp3` only) For Throughput, enter the throughput that the volume should provide, in MiB/s.

8.  For Availability Zone, choose the Availability Zone in which to create the volume. A volume can be attached only to an instance that is in the same Availability Zone.

12. (Optional) To assign custom tags to the volume, in the Tags section, choose Add tag, and then enter a tag key and value pair. For more information, see [Tag your Amazon EC2 resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html).

13. Choose Create volume.

    >Note  
    The volume is ready for use when the volume status is `Available`.

## Attach an Amazon EBS volume to an instance
**To attach an EBS volume to an instance using the console**

1.  Open the Amazon EC2 console at <https://console.aws.amazon.com/ec2/>.

2.  In the navigation pane, choose Volumes.

3.  Select the volume to attach and choose Actions, Attach volume.

    >Note  
    You can attach only volumes that are in the `Available` state.

4.  For Instance, enter the ID of the instance or select the instance from the list of options.

    >Note  
    >-   The volume must be attached to an instance in the same Availability Zone.

    >-   If the volume is encrypted, it can only be attached to instance types that support Amazon EBS encryption. For more information, see [Amazon EBS encryption](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html).

5.  For Device name, you can leave as default.

6.  Choose Attach volume.

7.  Connect to the instance and mount the volume. For more information, see [Make an Amazon EBS volume available for use on Linux](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html).  
In this lab, run following commands to make the volume available:  
    >       sudo mkfs -t xfs /dev/nvme1n1
    >       sudo mkdir /data
    >       sudo mount /dev/nvme1n1 /data
    >       df -h
## Create Amazon EBS snapshots
You can create a point-in-time snapshot of an EBS volume and use it as a baseline for new volumes or for data backup. If you make periodic snapshots of a volume, the snapshots are incremental—the new snapshot saves only the blocks that have changed since your last snapshot.

**To create a snapshot using the console**

1.  Open the Amazon EC2 console at <https://console.aws.amazon.com/ec2/>.

2.  In the navigation pane, choose Snapshots, Create snapshot.

3.  For Resource type, choose Volume.

4.  For Volume ID, select the volume from which to create the snapshot.

    The Encryption field indicates the selected volume's encryption status. If the selected volume is encrypted, the snapshot is automatically encrypted using the same KMS key. If the selected volume is unencrypted, the snapshot is not encrypted.

5.  (Optional) For Description, enter a brief description for the snapshot.

6.  (Optional) To assign custom tags to the snapshot, in the Tags section, choose Add tag, and then enter the key-value pair. You can add up to 50 tags.

7.  Choose Create snapshot.
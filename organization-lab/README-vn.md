# Tạo và cấu hình một organization
Trong bài thực hành này sẽ hướng dẫn các bạn sử dụng  [deny list](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#denylist) đảm bảo các user trong các tài khoản thành viên không thực hiện được các hành động trên một bucket S3.

Hình minh họa dưới đây thể hiện các bước chính trong bài hướng dẫn.

![](https://docs.aws.amazon.com/organizations/latest/userguide/images/tutorialorgs.png)

## Bước 1: Tạo organization
Ở bước này, bạn đăng nhập tài khoản administrator, tạo một organization với account đó như là account quản lý. 
1.  Đăng nhập vào AWS với tài khoản administrator và truy cập tới  [AWS Organizations console](https://console.aws.amazon.com/organizations/v2).

2.  Trên trang giới thiệu, chọn  **Create an organization**.

3.  Trong confirmation dialog box, Chọn **Create an organization**.

4.  Xác nhận Email của bạn trong vòng 24 giờ. Để biết thêm thông tin, xem tại [Email address verification](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_create.html#about-email-verification).

### Mời một account có sẵn tham gia organization

 Ở bước này, bạn mời một account tham gia vào  organization của bạn như một thành viên trong organization.

1.  Truy cập trang [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts), chọn **Add an AWS account**.

2.  On the [Add an AWS account](https://console.aws.amazon.com/organizations/v2/home/accounts/add/create) page, choose Invite an exisiting AWS account.

3.  Trong phần **Email address or account ID of an AWS account to invite**, điền root email của tài khoản bạn muốn mời, ví dụ: `member222@example.com`. Hoặc cách khác, nếu bạn biết AccountID, điền AccountID muốn mời.

4.  Nhập bất kỳ văn bản nào bạn muốn gửi kèm khi gửi đến email sở hữu của tài khoản thành viên.

5.  Chọn **Send invitation**. AWS Organizations sẽ gửi một email đến tài khoản được mời.

    >    Quan trọng  
    Nếu bạn gặp lỗi liên quan đến giới hạn của organization hoặc không thể thêm tài khoản do organization đang được khởi tạo, đợi 1 tiếng sau rồi thử lại. Nếu lỗi vẫn tiếp tục sảy ra, liên hệ [AWS Support](https://console.aws.amazon.com/support/home#/).

6. Thực hiện 1 trong các cách sau để chấp nhận lời mời tham gia organization:

    -   Mở email do AWS đã gửi, mở link đính kèm. Khi cửa sổ được mở ra, đăng nhập bằng tài khoản root của tài khoản được mời.

    -   Mở trang [AWS Organizations console](https://console.aws.amazon.com/organizations/v2) và chuyển hướng đến  [Invitations](https://console.aws.amazon.com/organizations/v2/home/accounts/invitations).

7.  Trong trang [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts), chọn **Accept** sau đó chọn **Confirm**.

Bước 2: Tạo organizational units
---------------------------------------

Trong phần này, bạn sẽ tạo organizational units (OUs) và đặt member accounts vào đó. Sau khi hoàn thành, Organization của bạn sẽ như ảnh minh họa phía dưới. Tài khoản management sẽ vẫn ở root. Một tài khoản sẽ được di chuyển đến Production OU, và một tài khoản khác được di chuyển đến MainApp OU.

![](https://docs.aws.amazon.com/organizations/latest/userguide/images/orgs-lab-structure.jpg)

1.  Trong trang [AWS Organizations console](https://console.aws.amazon.com/organizations/v2) di chuyển đến trang [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts).

2.  Chọn check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) Bên cạnh Root.

3.  Chọn Actions, sau đó dưới **Organizational unit**, chọn **Create new**.

4.  Trong trang **Create organizational unit**, với **Organizational unit name**, điền `Production` sau đó chọn **Create organizational unit**.

5.  Chọn check box ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) bên cạnh Production OU.

6.  Chọn **Actions**, chọn **Create new**.

7.  Trong trang **Create organizational unit**, với **Organizational unit name**, điền `MainApp` sau đó chọn **Create organizational unit**.
8. Trở lại trang [AWS accounts](https://console.aws.amazon.com/organizations/v2/home/accounts)
9. Mở rộng Organization bằng cách bấm vào biểu tượng hình tam giác ![](https://docs.aws.amazon.com/organizations/latest/userguide/images/expand-icon.png)


11. Chọn tên account![](https://docs.aws.amazon.com/organizations/latest/userguide/images/checkbox-selected.png) , chọn **Actions**, chọn **Move**.

12. Trong trang  Move AWS account, chọn Production OU hoặc Mainapp, sau đó cọn Move AWS Account.


Bước 3: Tạo service control policies
-------------------------------------------

Trong phần này, bạn sẽ tạo [service control policies (SCPs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) và gắn nó vào root hoặc OU để giới hạn user trong organization sẽ không thể thực hiện các hành động trên S3 bucket.

### Bật service control policy cho organization

Trước khi bạn có thể gắn một policy vào root hoặc OU, bạn phải bật kiểu policy đó cho organization.  Những bước dưới đây sẽ hướng dẫn bạn bật service control policy (SCP) cho organization.

1.  Di chuyển đến trang [Policies](https://console.aws.amazon.com/organizations/v2/home/policies), và chọn Service Control Policies.

2.  Trên trang [Service control policies](https://console.aws.amazon.com/organizations/v2/home/policies/service-control-policy), chọn Enable service control policies.

### Tạo SCPs

Bây giờ bạn có thể tạo SCP cho bài thực hành này.
Để tạo SCP chặn tất cả hành động trên S3, thực hiện các bước sau:

1.  Di chuyển đến trang [Policies](https://console.aws.amazon.com/organizations/v2/home/policies), và chọn Service Control Policies.

2.  Trong trang [Service control policies](https://console.aws.amazon.com/organizations/v2/home/policies/service-control-policy), chọn Create policy.


3.  Cho Policy name, điền `Block S3`.

4.  Trong phần Policy, điền đoạn lệnh sau:

        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "Stmt1234567890123",
            "Effect": "Deny",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "*"
            ]
            }
        ]
        }
6. Chọn Create policy.

## Step 4: Kiểm tra organization's policies
Bây giờ bạn có thể đăng nhập vào các tài khoản thành viên và truy cập vào S3 và thực hiện các hành động trên đó. Bạn sẽ nhận được thông báo như sau: `You don't have permissions to list buckets`
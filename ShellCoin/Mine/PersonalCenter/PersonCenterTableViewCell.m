//
//  PersonCenterTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "PersonCenterTableViewCell.h"
#import "ManagerBankCardViewController.h"
#import "RealnameViewController.h"
#import "NoBankCardViewController.h"
#import "MyQrCodeViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import <QiniuSDK.h>
#import "MyCollectionListViewController.h"


@interface PersonCenterTableViewCell()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign)BOOL isHaveBankCard;

@end

@implementation PersonCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.yetRMarkBtn.enabled = YES;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImageView.layer.borderWidth = 5;
    self.headImageView.layer.cornerRadius = TWitdh*(10/15.) * (6/10.) /2.;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHead)];
    [self.headImageView addGestureRecognizer:tap];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[ShellCoinUserInfo shareUserInfos].avatar] placeholderImage:[UIImage imageNamed:@"header.jpg"] completed:NULL];

    self.bankLabel.textColor = self.vipLabel.textColor = self.realNameLabel.textColor = self.qrCodeLabel.textColor = self.myCollectionlabel.textColor = MacoTitleColor;
    [self.realNameBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    [self setRealNameInfo];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


#pragma mark - 是否实名认证
- (void)setRealNameInfo
{
    //获取用户最新消息
    NSString *token = [ShellCoinUserInfo shareUserInfos].token;
    
    
    [HttpClient POST:@"user/userBaseInfo/get" parameters:@{@"token":token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
        [[ShellCoinUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
        [ShellCoinUserInfo shareUserInfos].token = token;
        if ([ShellCoinUserInfo shareUserInfos].identityFlag) {
            self.nameLabel.hidden = NO;
            self.yetRMarkBtn.hidden = NO;
            self.nameLabel.text = [ShellCoinUserInfo shareUserInfos].idcardName;
            self.realNameBtn.hidden = YES;
            }else{
                self.nameLabel.hidden = YES;
                self.yetRMarkBtn.hidden = YES;
                self.realNameBtn.hidden = NO;
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];

}

#pragma mark - 改变头像
- (void)changeHead{
    NSLog(@"changeHead");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择",@"拍照", nil];
    [sheet showInView:self.viewController.view];
}

- (IBAction)backBtn:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
- (IBAction)realNameBtn:(id)sender {
    if ([ShellCoinUserInfo shareUserInfos].idVerifyReqFlag) {
        RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
        realnameVC.isWaitAut = YES;
        [self.viewController.navigationController pushViewController:realnameVC animated:YES];
        
        return;
    }
    
    RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
    if ([ShellCoinUserInfo shareUserInfos].identityFlag) {
        realnameVC.isYetAut = YES;
    }else{
        realnameVC.isYetAut = NO;
    }
    [self.viewController.navigationController pushViewController:realnameVC animated:YES];
}
- (IBAction)bankBtn:(id)sender {
    
    if ([ShellCoinUserInfo shareUserInfos].bindingFlag) {
        ManagerBankCardViewController *manageVC = [[ManagerBankCardViewController alloc]init];
        [self.viewController.navigationController pushViewController:manageVC animated:YES];
        return;
    }
    NoBankCardViewController *noBancardVC = [[NoBankCardViewController alloc]init];
    [self.viewController.navigationController pushViewController:noBancardVC animated:YES];
    
}

- (IBAction)vipBtn:(id)sender {
    
    
}
- (IBAction)realNameManageBtn:(id)sender{
    
    if ([ShellCoinUserInfo shareUserInfos].idVerifyReqFlag) {
        RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
        realnameVC.isWaitAut = YES;
        [self.viewController.navigationController pushViewController:realnameVC animated:YES];

        return;
    }
    
    RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
    if ([ShellCoinUserInfo shareUserInfos].identityFlag) {
        realnameVC.isYetAut = YES;
    }else{
        realnameVC.isYetAut = NO;
    }
    [self.viewController.navigationController pushViewController:realnameVC animated:YES];
    
}


- (IBAction)qrCodeBtn:(id)sender {
    MyQrCodeViewController *qrCodeVC = [[MyQrCodeViewController alloc]init];
    [self.viewController.navigationController pushViewController:qrCodeVC animated:YES];
}


- (IBAction)mycollectionBtn:(id)sender {
    MyCollectionListViewController *myCollectionVC = [[MyCollectionListViewController alloc]init];
    [self.viewController.navigationController pushViewController:myCollectionVC animated:YES];
}


#pragma mark - 上传头像


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self presentAlbum];
        }
            break;
            //进入照相界面
        case 1:
        {
            
            [self prsentCamera];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 进入照相机
- (void)prsentCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"该设备不支持照相");
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.viewController presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark - 打开本地相册
- (void)presentAlbum
{
    if ([LBXScanWrapper isGetPhotoPermission])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.delegate = self;
        
        
        picker.allowsEditing = YES;
        
        
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

#pragma mark -- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    [HttpClient POST:@"user/getQiniuToken" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        
        NSString *qiniuToken = jsonObject[@"data"];
        
        [weakSelf upLoadImage:image withToken:qiniuToken];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark - 上传照片
- (void)upLoadImage:(UIImage *)image withToken:(NSString *)qiniuToken
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormatterString];
    NSString *string = [formatter stringFromDate:date];
    NSString *strRandom = @"";
    for(int i=0; i< 6; i++)
    {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    
    NSString *imageSuffix = @"jpg";
    NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
    if (!imageData) {
        imageData = UIImagePNGRepresentation(image);
        imageSuffix = @"png";
    }
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        QNServiceAddress *s1 = [[QNServiceAddress alloc] init:@"https://upload.qbox.me" ips:@[@"183.136.139.16"]];
        QNServiceAddress *s2 = [[QNServiceAddress alloc] init:@"https://up.qbox.me" ips:@[@"183.136.139.16"]];
        builder.zone = [[QNZone alloc] initWithUp:s1 upBackup:s2];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    NSString *randomDkey = [NSString stringWithFormat:@"%@.%@",[string stringByAppendingString:strRandom],imageSuffix];
    [SVProgressHUD showWithStatus:@"正在上传头像"];
    [upManager putData:imageData key:randomDkey token:qiniuToken
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  [SVProgressHUD dismiss];
                  if (info.error) {
                      [SVProgressHUD dismiss];
                      [[JAlertViewHelper shareAlterHelper]showTint:@"头像上传失败,请稍后重试" duration:1.5];
                      return;
                  }
                  NSDictionary *prams = @{@"avatar":resp[@"key"],
                                          @"token":[ShellCoinUserInfo shareUserInfos].token};
                  [HttpClient POST:@"user/userInfo/update" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
                      if (IsRequestTrue) {
                          [ShellCoinUserInfo shareUserInfos].avatar = jsonObject[@"data"][@"avatar"];
                          [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[ShellCoinUserInfo shareUserInfos].avatar] placeholderImage:[UIImage imageNamed:@"header.jpg"] completed:NULL];

                          [SVProgressHUD showSuccessWithStatus:@"头像修改成功"];

                          
                      }
                      
                  } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                      [SVProgressHUD dismiss];
                  }];
                  
              } option:nil];
}



@end

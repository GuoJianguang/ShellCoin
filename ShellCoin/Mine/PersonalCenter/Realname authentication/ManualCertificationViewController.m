//
//  ManualCertificationViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManualCertificationViewController.h"
#import <QiniuSDK.h>
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "RealNameAutResultView.h"


@interface ManualCertificationViewController ()<BasenavigationDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)NSString *idPhoto;
@property (nonatomic, assign)BOOL isSelectPhoto;
@property (nonatomic, strong)RealNameAutResultView *resultView;

@end

@implementation ManualCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


- (void)backBtnClick
{
    if (self.resultView.isSuccess == Authentication_wait_success) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 提交
- (void)detailBtnClick
{
    [self.idcardTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
    if ([self valueValidated]) {
        __weak __typeof(self) weakSelf = self;
        [SVProgressHUD showWithStatus:@"正在发送请求" maskType:SVProgressHUDMaskTypeBlack];
        [HttpClient POST:@"user/getQiniuToken" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
            
            NSString *qiniuToken = jsonObject[@"data"];
            
            [weakSelf upLoadImage:self.idCardBtn.currentBackgroundImage withToken:qiniuToken];
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入姓名" duration:1.5];
        return NO;
    }else if ([self emptyTextOfTextField:self.idcardTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入证件号码" duration:1.5];
        return NO;
    }else if (!self.isSelectPhoto){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请设置您的证件照" duration:1.5];
        return NO;
    }
    //    Verify *ver = [[Verify alloc]init];
    //    if (![ver verifyIDNumber:self.idCardNumTF.text]) {
    //        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的身份证号码" duration:1.5];
    //        return NO;
    //    }
    return YES;
}
-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)idCardBtn:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机选择",@"拍照", nil];
    [sheet showInView:self.view];
    return;
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
        builder.zone = [[QNFixedZone alloc] initWithUp:s1 upBackup:s2];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    NSString *randomDkey = [NSString stringWithFormat:@"%@.%@",[string stringByAppendingString:strRandom],imageSuffix];
    [upManager putData:imageData key:randomDkey token:qiniuToken
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (info.error) {
                      [SVProgressHUD dismiss];
                      [[JAlertViewHelper shareAlterHelper]showTint:@"证件照上传失败,请稍后重试" duration:1.5];
                      return;
                  }
                  self.idPhoto = NullToSpace(resp[@"key"]);
                  
                  NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                          @"cardNo":self.idcardTF.text,
                                          @"idcardName":self.nameTF.text,
                                          @"idPhoto":NullToSpace(self.idPhoto)};
                  [HttpClient POST:@"user/verifyIdcardReq" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                      [SVProgressHUD dismiss];
                      if (IsRequestTrue) {
                          [ShellCoinUserInfo shareUserInfos].idVerifyReqFlag = YES;
                          [self authenSuccess];
                      }
                      
                  } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                      [SVProgressHUD dismiss];
                      [[JAlertViewHelper shareAlterHelper]showTint:@"认证失败,请稍后重试" duration:1.5];
                  }];
                  
              } option:nil];
}

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
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
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
        
        
        [self presentViewController:picker animated:YES completion:nil];
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
    
    self.idCardBtn.layer.masksToBounds = YES;
    [self.idCardBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    self.isSelectPhoto = YES;
    
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

#pragma makr - 提交成功
- (void)authenSuccess
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.resultView.isSuccess = Authentication_wait_success;
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

- (RealNameAutResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[RealNameAutResultView alloc]init];
    }
    return _resultView;
}

@end

//
//  ChangePayPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ChangePayPasswordViewController.h"


@interface ChangePayPasswordViewController ()<BasenavigationDelegate>
@property (nonatomic,strong) NSTimer *timer1;

@end

@implementation ChangePayPasswordViewController

{
    int timeLefted1;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"重置支付密码";
    self.naviBar.delegate = self;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];
    self.naviBar.hiddenDetailBtn = NO;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    
    self.phoneTF.enabled = NO;
    timeLefted1 = 60;
    self.phoneTF.text = [ShellCoinUserInfo shareUserInfos].phone;

    [self.verCodeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.phoneTF.textColor = self.xinPayTF.textColor = self.verCodeTF.textColor = self.sureNewPayTF.textColor = self.fingerCodeLabel.textColor =MacoTitleColor;
    self.phoneLabel.textColor = self.xinPayLabel.textColor = self.verCodeLabel.textColor = self.sureNewPayLabel.textColor= MacoDetailColor;
}

- (void)detailBtnClick
{
    [self.phoneTF resignFirstResponder];
    [self.verCodeTF resignFirstResponder];
    [self.xinPayTF resignFirstResponder];
    [self.sureNewPayTF resignFirstResponder];
    if ([self valueValidated]) {
        NSString *newPassword = [[NSString stringWithFormat:@"%@%@",self.xinPayTF.text,PasswordKey]md5_32];
        [SVProgressHUD showWithStatus:@"正在提交请求..."];
        NSDictionary *parms = @{@"payPassword":newPassword,
                                @"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"verifyCode":self.verCodeTF.text};
        
        [HttpClient GET:@"user/payPassword/update" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"修改失败，请稍后重试" duration:2];

            [SVProgressHUD dismiss];
        }];
    }
    
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


-(BOOL) valueValidated {
     if ([self emptyTextOfTextField:self.verCodeTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入验证码" duration:2.];
        return NO;
     }else if ([self emptyTextOfTextField:self.xinPayTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新的支付密码" duration:2.];
        return NO;
    }else if (self.xinPayTF.text.length<6 || self.xinPayTF.text.length > 18){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码必须在6-18位之间" duration:2.];
        return NO;
    }else if ([self emptyTextOfTextField:self.sureNewPayTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请重复新的支付密码" duration:2.];
        return NO;
    }else if (![self.xinPayTF.text isEqualToString:self.sureNewPayTF.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:2.];
        return NO;
    }
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

- (IBAction)verCodeBtn:(UIButton *)sender {
    sender.enabled = NO;
    NSDictionary *parms = @{@"phone":self.phoneTF.text};
    [HttpClient POST:@"sms/sendModifyPayPwdCode" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.verCodeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
            [self.verCodeBtn setTitleColor:MacoIntrodouceColor forState:UIControlStateNormal];
            self.verCodeBtn.enabled = NO;
            self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(oldTimeLeft:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer1 forMode:NSRunLoopCommonModes];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        sender.enabled = YES;
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - 验证码计时器
//static int timeLefted = 60;
-(void) oldTimeLeft:(NSTimer*) timer {
    
    timeLefted1--;
    if (timeLefted1 == 0) {
        [self oldverifyButtonNormal];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted1];
    self.verCodeBtn.titleLabel.text = title;
    [self.verCodeBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void) oldverifyButtonNormal {
    [self.timer1 invalidate];
    timeLefted1 = 60;
    self.verCodeBtn.layer.borderColor = MacoColor.CGColor;
    [self.verCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.verCodeBtn.enabled = YES;
}
- (IBAction)finggerCodeSwitch:(UISwitch *)sender {

}
@end

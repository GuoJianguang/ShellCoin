//
//  SetPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SetPayPasswordViewController.h"

@interface SetPayPasswordViewController ()<BasenavigationDelegate>

@end

@implementation SetPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"设置支付密码";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    
    self.surePasswrodLabel.textColor = self.setPasswordLabel.textColor =MacoDetailColor;
    self.surePasswordTF.textColor = self.setpasswordTF.textColor =self.openFingerprintlabel.textColor= MacoTitleColor;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];

}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}

#pragma mark - 确认按钮
- (void)detailBtnClick
{
    if ([self valueValidated]) {
        [self.surePasswordTF resignFirstResponder];
        [self.setpasswordTF resignFirstResponder];
        [SVProgressHUD showWithStatus:@"正在提交请求..."];
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.surePasswordTF.text,PasswordKey]md5_32];
        NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"payPassword":password};
        [HttpClient POST:@"user/payPassword/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                [ShellCoinUserInfo shareUserInfos].payPassword = self.surePasswordTF.text;
                [[JAlertViewHelper shareAlterHelper]showTint:@"设置成功" duration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];

        }];
    }
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.setpasswordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入支付密码" duration:2.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePasswordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请确认输入支付密码" duration:2.];
        return NO;
    }else if (self.setpasswordTF.text.length<6 || self.setpasswordTF.text.length > 18){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码必须在6-18位之间" duration:1.];
        return NO;
    }else if (![self.setpasswordTF.text isEqualToString:self.surePasswordTF.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:1.];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
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

- (IBAction)openSwitch:(id)sender {
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
@end

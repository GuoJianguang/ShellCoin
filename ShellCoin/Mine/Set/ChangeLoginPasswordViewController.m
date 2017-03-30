//
//  ChangeLoginPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ChangeLoginPasswordViewController.h"

@interface ChangeLoginPasswordViewController ()<BasenavigationDelegate>

@end

@implementation ChangeLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"修改登录密码";
    self.naviBar.delegate = self;
    self.naviBar.detailTitle = @"确认";
    self.naviBar.hiddenDetailBtn = NO;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    
    self.oldPasswordLabel.textColor = self.xinPassowrdLabel.textColor = self.surePasswrodLabel.textColor  = MacoDetailColor;
    self.xinPasswordTF.textColor = self.oldPassowrodTF.textColor = self.surePasswordTF.textColor  = MacoTitleColor;

}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


- (void)detailBtnClick
{
    if ([self valueValidated]) {
        NSString *oldPassword = [[NSString stringWithFormat:@"%@%@",self.oldPassowrodTF.text,PasswordKey]md5_32];
        NSString *newPassword = [[NSString stringWithFormat:@"%@%@",self.xinPasswordTF.text,PasswordKey]md5_32];
        
        [SVProgressHUD showWithStatus:@"正在提交请求..."];
        NSDictionary *parms = @{@"oldPassword":oldPassword,
                                @"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"newPassword":newPassword};
        [HttpClient POST:@"user/updatePassword" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
                [[NSUserDefaults standardUserDefaults]setObject:self.xinPasswordTF.text forKey:LoginUserPassword];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }

}



-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.oldPassowrodTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入旧密码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.xinPasswordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新密码" duration:1.];
        return NO;
    }else if (self.xinPasswordTF.text.length<6 || self.xinPasswordTF.text.length > 18){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码必须在6-18位之间" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePasswordTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请重复新密码" duration:1.];
        return NO;
    }else if (![self.xinPasswordTF.text isEqualToString:self.surePasswordTF.text]){
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

@end

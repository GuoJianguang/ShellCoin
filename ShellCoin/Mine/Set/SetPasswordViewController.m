//
//  SetPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "SetPayPasswordViewController.h"
#import "ChangeLoginPasswordViewController.h"
#import "ChangePayPasswordViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>



@interface SetPasswordViewController ()

@property (nonatomic, assign)BOOL isHavePayPassowrd;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.payPasswordLabel.textColor = self.payloginPasswordLabel.textColor = self.fingerprintLabel.textColor= MacoTitleColor;
//    self.finggerCodeSwitch.enabled = NO;

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[ShellCoinUserInfo shareUserInfos].payPassword isEqualToString:@""]) {
        self.payPasswordLabel.text = @"设置支付密码";
        self.finggerCodeSwitch.on = NO;
        self.isHavePayPassowrd = NO;
    }else{
        self.isHavePayPassowrd = YES;
        self.payPasswordLabel.text = @"重置支付密码";
        
    }
    if ([ShellCoinUserInfo shareUserInfos].payPwdFlag) {
        self.finggerCodeSwitch.on = YES;
        
    }else{
        self.finggerCodeSwitch.on = NO;
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtn:(id)sender {
    ChangeLoginPasswordViewController *changeLoginVC = [[ChangeLoginPasswordViewController alloc]init];
    [self.navigationController pushViewController:changeLoginVC animated:YES];
}

- (IBAction)paypasswordBtn:(id)sender {
    if (self.isHavePayPassowrd) {
        ChangePayPasswordViewController *changePasswordVC = [[ChangePayPasswordViewController alloc]init];
        [self.navigationController pushViewController:changePasswordVC animated:YES];
        return;
    }
    SetPayPasswordViewController *setPayPasswordVC = [[SetPayPasswordViewController alloc]init];
    [self.navigationController pushViewController:setPayPasswordVC animated:YES];
}


- (IBAction)finggerCodeSwitch:(UISwitch *)sender
{
 }
- (IBAction)switch:(UISwitch *)sender {
    
}
- (IBAction)changeSwitchOn:(UIButton *)sender {
    
    if (!self.finggerCodeSwitch.on) {
        if ([[ShellCoinUserInfo shareUserInfos].payPassword isEqualToString:@""]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先设置支付密码" duration:2.0];
            self.finggerCodeSwitch.on = NO;
            return;
        }
        LAContext * con = [[LAContext alloc]init];
        NSError * error;
        //判断是否支持密码验证
        /**
         *LAPolicyDeviceOwnerAuthentication 手机密码的验证方式
         *LAPolicyDeviceOwnerAuthenticationWithBiometrics 指纹的验证方式
         */
        BOOL can = [con canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
        if (can) {
            [con evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证信息" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    //                    NSString *password = [[NSString stringWithFormat:@"%@%@",,PasswordKey]md5_32];
                    
                    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                            @"payPassword":[ShellCoinUserInfo shareUserInfos].payPassword};
                    [SVProgressHUD showWithStatus:@"正在开启指纹验证"];
                    [HttpClient POST:@"user/payPassword/ignore" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                        [SVProgressHUD dismiss];
                        if (IsRequestTrue) {
                            [[JAlertViewHelper shareAlterHelper]showTint:@"指纹验证开启成功" duration:2.0];
                            [ShellCoinUserInfo shareUserInfos].payPwdFlag = YES;
                            self.finggerCodeSwitch.on = YES;
                        }
                        
                    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                        [[JAlertViewHelper shareAlterHelper]showTint:@"指纹验证开启失败，请重试" duration:2.0];
                        self.finggerCodeSwitch.on = NO;
                    }];
                    return;
                }
                
                
                self.finggerCodeSwitch.on = NO;;
                NSLog(@"%d,%@",success,error);
            }];
            
        }
    }else{
        [SVProgressHUD showWithStatus:@"正在关闭指纹验证"];

        [HttpClient POST:@"user/payPassword/ignore/cancel" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"指纹验证已关闭" duration:2.0];
                [ShellCoinUserInfo shareUserInfos].payPwdFlag= NO;
                self.finggerCodeSwitch.on = NO;
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [[JAlertViewHelper shareAlterHelper]showTint:@"数据获取失败，请重试" duration:2.0];
            self.finggerCodeSwitch.on = YES;
        }];
    }

}
@end

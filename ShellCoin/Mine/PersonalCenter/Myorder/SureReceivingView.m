//
//  SureTradInView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureReceivingView.h"
#import "ChangePayPasswordViewController.h"
#import "RealnameViewController.h"


@interface SureReceivingView()

@end
@implementation SureReceivingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureReceivingView" owner:nil options:nil][0];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self sendSubviewToBack:self.blackBackgoundView];
        self.passwordTF.layer.cornerRadius = (TWitdh-120) *(8/52.)/2.;
        self.passwordTF.layer.borderWidth =1;
        self.passwordTF.layer.borderColor = MacoColor.CGColor;
        self.passwordTF.textColor = MacoColor;
        self.passwordTF.layer.masksToBounds = YES;
        [self.forgetBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
        
        [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}
- (IBAction)cancelBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
}

- (IBAction)sureBtn:(UIButton *)sender {
    if ([self.passwordTF.text isEqualToString:@""] || !self.passwordTF.text) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入支付密码" duration:1.5];
        return ;
    }
    [self.passwordTF resignFirstResponder];
    
    [self sureReceiving:sender];

}

- (IBAction)forgetBtn:(UIButton *)sender {
    
    ChangePayPasswordViewController *changPayVC = [[ChangePayPasswordViewController alloc]init];
    [self.viewController.navigationController pushViewController:changPayVC animated:YES];
}


#pragma mark - 确认收货的接口
- (void)sureReceiving:(UIButton *)sender
{
    
    sender.enabled = NO;
    NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
    NSDictionary *prams = @{@"orderId":NullToSpace(self.orderId),
                            @"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"payPassword":password};
    [SVProgressHUD showWithStatus:@"正在发送请求"];
    [HttpClient POST:@"shop/order/confirm" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        sender.enabled = YES;
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if ([self.delegate respondsToSelector:@selector(sureReceivingsuccess:)]) {
                [self.delegate sureReceivingsuccess:@"确认收货成功"];
            }
            [self removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        sender.enabled = YES;
        [[JAlertViewHelper shareAlterHelper]showTint:@"确认收货失败，请重试" duration:2.0];
    }];

}
#pragma mark - 判断是否实名认证
- (BOOL)gotRealNameRu:(NSString *)alerTitle
{
    if (![ShellCoinUserInfo shareUserInfos].identityFlag) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去进行实名认证
            RealnameViewController *realNVC = [[RealnameViewController alloc]init];
//            realNVC.isYetAut = NO;
            [self.viewController.navigationController pushViewController:realNVC animated:YES];
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}




@end

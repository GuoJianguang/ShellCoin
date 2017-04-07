//
//  SureTradInView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureTradInView.h"
#import "ChangePayPasswordViewController.h"
#import "RealnameViewController.h"


@interface SureTradInView()

@end
@implementation SureTradInView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureTradInView" owner:nil options:nil][0];
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

- (void)setMallOrderParms:(NSMutableDictionary *)mallOrderParms
{
    _mallOrderParms = mallOrderParms;
}

- (IBAction)sureBtn:(UIButton *)sender {
    
    
    if ([self.passwordTF.text isEqualToString:@""] || !self.passwordTF.text) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入支付密码" duration:1.5];
        return ;
    }
    [self.passwordTF resignFirstResponder];
    
    switch (self.inputType) {
        case Password_type_withdraw:
        {
            [self getWithDrawRequest:sender];
        }
            break;
        case Password_type_MerchantOnlinePay:
        {
            [self gotMerchantOnlinePay:sender];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)forgetBtn:(UIButton *)sender {
    
    ChangePayPasswordViewController *changPayVC = [[ChangePayPasswordViewController alloc]init];
    [self.viewController.navigationController pushViewController:changPayVC animated:YES];
}


#pragma mark - 抵换的接口请求

- (void)getWithDrawRequest:(UIButton *)sender
{
    //抵换的接口请求
    NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
    [self.mallOrderParms setObject:password forKey:@"password"];
    [SVProgressHUD showWithStatus:@"正在提交申请"];
    [HttpClient POST:@"user/withdraw/add" parameters:self.mallOrderParms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        sender.enabled = YES;
        if (IsRequestTrue) {
            if ([self.delegate respondsToSelector:@selector(paysuccess:)]) {
                [self.delegate paysuccess:self.mallOrderParms[@"withdrawAmount"]];
            }
            [self removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败，请重试" duration:2.0];
        sender.enabled = YES;
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 商城在线支付
- (void)gotMerchantOnlinePay:(UIButton *)sender
{
    if ([self gotRealNameRu:@"在您用余额支付之前，请先进行实名认证"]) {
        return;
    }
    sender.enabled = NO;
    NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
    
    [self.mallOrderParms setObject:password forKey:@"password"];
    [SVProgressHUD showWithStatus:@"正在支付"];
    [HttpClient POST:@"pay/mch/balance" parameters:self.mallOrderParms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        sender.enabled = YES;
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if ([self.delegate respondsToSelector:@selector(paysuccess:)]) {
                [self.delegate paysuccess:self.mallOrderParms[@"tranAmount"]];
            }
            [self removeFromSuperview];
            //            if ([self.delegate respondsToSelector:@selector(paysuccess:)]) {
            //                [TTXUserInfo shareUserInfos].consumeBalance = [NSString stringWithFormat:@"%.2f",self.xiaofeiJinMoney];
            //                [self.delegate paysuccess:@"余额支付"];
            //            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败，请重试" duration:2.0];
        sender.enabled = YES;
        //        if ([self.delegate respondsToSelector:@selector(payfail)]) {
        //            [self.delegate payfail];
        //        }
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

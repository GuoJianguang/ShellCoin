//
//  OnlinePayViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OnlinePayViewController.h"
#import "SureTradInView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "OnlinePayResultView.h"

@interface OnlinePayViewController ()<BasenavigationDelegate,PayViewDelegate>

@property (nonatomic, assign)double xiaofeiJinMoney;
@property (nonatomic, strong)SureTradInView *inputPasswordView;
@property (nonatomic, strong)OnlinePayResultView *resultView;
@end

@implementation OnlinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"支付";
    self.naviBar.delegate = self;
    self.merchantName.text = self.dataModel.name;
    self.merchantName.textColor = self.moneyLabel.textColor = MacoTitleColor;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.money];
    [self setPayWay];
    self.yuELabel.adjustsFontSizeToFitWidth = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weixinPayResult:) name:WeixinPayResult object:nil];

}

- (SureTradInView *)inputPasswordView
{
    if (!_inputPasswordView) {
        _inputPasswordView = [[SureTradInView alloc]init];
    }
    return _inputPasswordView;
}

#pragma mark - 设置支付规则
- (void)setPayWay{
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
    self.cashImage.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor = self.cashLabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = self.cashMarkBtn.hidden = YES;
    //默认余额支付
    self.payWay_type = Payway_type_banlance;
    double xiaofeiJin = [[ShellCoinUserInfo shareUserInfos].consumeBalance doubleValue];
    double payMoney = [self.money doubleValue];
    double yuE = [[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue];
    
    
    if (xiaofeiJin >= payMoney) {
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(消费金%.2f元)",payMoney];
        self.xiaofeiJinMoney = xiaofeiJin - payMoney;
    }else if (payMoney > xiaofeiJin && payMoney - xiaofeiJin < yuE && xiaofeiJin !=0){
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(消费金%.2f元+余额%.2f元)",xiaofeiJin,(payMoney - xiaofeiJin)];
        self.xiaofeiJinMoney = 0;
    }else if(xiaofeiJin==0 && payMoney < yuE){
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(余额%.2f元)",payMoney];
        self.xiaofeiJinMoney = 0;
    }else if(payMoney > yuE + xiaofeiJin){
        self.yuELabel.text = [NSString stringWithFormat:@"余额和消费金额不足，请用微信或者现金支付"];
        
        self.payWay_type = Payway_type_wechat;
        self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
        self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
        self.cashImage.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
        self.yuEMarkBtn.hidden = self.cashMarkBtn.hidden= YES;
        self.wechatBtn.selected = YES;
        self.wechatLabel.textColor = MacoColor;
        self.yuELabel.textColor = MacoTitleColor;
        self.wechatMarkBtn.hidden = NO;
        self.yuEMarkBtn.enabled = self.yuEbtn.enabled = NO;
        return;
    }
    
    self.yuEMarkBtn.enabled = self.yuEbtn.enabled = YES;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)yuEBtn:(UIButton *)sender {
    self.payWay_type = Payway_type_banlance;
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
    self.cashImage.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor = self.cashLabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = self.cashMarkBtn.hidden = YES;
}
- (IBAction)wechatBtn:(UIButton *)sender {
    
    self.payWay_type = Payway_type_wechat;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.cashImage.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
    self.yuEMarkBtn.hidden = self.cashMarkBtn.hidden= YES;
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.yuELabel.textColor = self.cashLabel.textColor=MacoTitleColor;
    self.wechatMarkBtn.hidden = NO;
}

- (IBAction)cashBtn:(UIButton *)sender {
    self.payWay_type = Payway_type_cash;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
    self.cashImage.image = [UIImage imageNamed:@"icon_cash_payment_sel"];
    self.yuEMarkBtn.hidden = self.wechatMarkBtn.hidden = YES;
    self.cashMarkBtn.hidden = NO;
    self.wechatBtn.selected = YES;
    self.cashLabel.textColor = MacoColor;
    self.yuELabel.textColor=self.wechatLabel.textColor = MacoTitleColor;

}
- (IBAction)sureBtn:(UIButton *)sender {
    
    switch (self.payWay_type) {
        case Payway_type_wechat:
        {
            NSString *totalMoney = NullToNumber(self.money);
            NSString *md5Str = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword],PasswordKey];
            NSString *sign = [md5Str md5_32];
            
            NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                    @"mchCode":NullToNumber(self.dataModel.code),
                                    @"tranAmount":totalMoney,
                                    @"password":sign};
            [WeXinPayObject srarMachantWexinPay:prams];
        }
            break;
        case Payway_type_cash:
        {
            [self cashPay];
        }
            break;
        case Payway_type_banlance:
        {
            [self surePay];
        }
            break;
            
        default:
            break;
    }
}

- (void)surePay
{
    if ([ShellCoinUserInfo shareUserInfos].payPwdFlag) {
        LAContext * con = [[LAContext alloc]init];
        NSError * error;
        //判断是否支持密码验证
        /**
         *LAPolicyDeviceOwnerAuthentication 手机密码的验证方式
         *LAPolicyDeviceOwnerAuthenticationWithBiometrics 指纹的验证方式
         */
        [con evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证信息" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.money doubleValue]];
                NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                        @"mchCode":NullToSpace(self.dataModel.code),
                                        @"tranAmount":totalMoney,
                                        @"password":[ShellCoinUserInfo shareUserInfos].payPassword};
                [SVProgressHUD showWithStatus:@"正在提交申请"];
                [HttpClient POST:@"pay/mch/balance" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
                    [SVProgressHUD dismiss];
                    if (IsRequestTrue) {
//                        [[JAlertViewHelper shareAlterHelper]showTint:@"支付成功" duration:2.];
                        [self withDrawalSuccess];
                    }
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [SVProgressHUD dismiss];
                    [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];
                    //        if ([self.delegate respondsToSelector:@selector(payfail)]) {
                    //            [self.delegate payfail];
                    //        }
                }];
                return;
            }
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消指纹验证或者验证失败，请用使用支付密码发起抵换请求" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self goinputPassword];
            }];
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self presentViewController:alertcontroller animated:YES completion:NULL];
        }];
        return;
    }

    [self goinputPassword];

}


- (void)goinputPassword
{
    [self.view addSubview:self.inputPasswordView];
    NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.money doubleValue]];
    self.inputPasswordView.passwordTF.text = @"";
    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"mchCode":NullToSpace(self.dataModel.code),
                            @"tranAmount":totalMoney};
    self.inputPasswordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:prams];
    self.inputPasswordView.delegate = self;
    self.inputPasswordView.inputType = Password_type_MerchantOnlinePay;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.inputPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.inputPasswordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.inputPasswordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}

- (void)cashPay
{
    NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.money doubleValue]];
    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"mchCode":NullToSpace(self.dataModel.code),
                            @"tranAmount":totalMoney};
    [HttpClient POST:@"pay/mch/cash" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
//            [[JAlertViewHelper shareAlterHelper]showTint:@"支付成功" duration:2.];
            [self withDrawalSuccess];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];

    }];
    
}

#pragma mark - 支付结果
- (OnlinePayResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[OnlinePayResultView alloc]init];
    }
    return _resultView;
}

- (void)withDrawalSuccess
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.resultView.successLabel.text = self.dataModel.name;
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",self.money];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}


- (void)paysuccess:(NSString *)payWay
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.resultView.successLabel.text = self.dataModel.name;
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",payWay];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

#pragma mark - 微信支付结果回调
- (void)weixinPayResult:(NSNotification *)notification
{
    //    WXSuccess           = 0,    /**< 成功    */
    //    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //    WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    NSString *code = notification.userInfo[@"resultcode"];
    switch ([code intValue]) {
        case WXSuccess:
        {
            [self paysuccess:self.money];
        }
            
            break;
        case WXErrCodeCommon:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];
            
            break;
        case WXErrCodeUserCancel:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您已取消支付" duration:2.];
            
            break;
        case WXErrCodeSentFail:
            [[JAlertViewHelper shareAlterHelper]showTint:@"发起支付请求失败" duration:2.];
            
            break;
        case WXErrCodeAuthDeny:
            [[JAlertViewHelper shareAlterHelper]showTint:@"微信支付授权失败" duration:2.];
            break;
        case WXErrCodeUnsupport:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您未安装微信客户端,请先安装" duration:2.];
            break;
        default:
            break;
    }
}

- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WeixinPayResult object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

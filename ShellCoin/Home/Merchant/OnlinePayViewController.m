//
//  OnlinePayViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OnlinePayViewController.h"
#import "SureTradInView.h"

@interface OnlinePayViewController ()

@property (nonatomic, assign)double xiaofeiJinMoney;
@property (nonatomic, strong)SureTradInView *inputPasswordView;

@end

@implementation OnlinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"支付";
    self.merchantName.text = self.dataModel.name;
    self.merchantName.textColor = self.moneyLabel.textColor = MacoTitleColor;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.money];
    [self setPayWay];
    self.yuELabel.adjustsFontSizeToFitWidth = YES;
    
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
    self.payWay_type = Payway_type_wechat;
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
            [self surePay];

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
    [self.view addSubview:self.inputPasswordView];
    NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.money doubleValue]];

    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"mchCode":NullToSpace(self.dataModel.code),
                            @"tranAmount":totalMoney};
    self.inputPasswordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:prams];
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


@end

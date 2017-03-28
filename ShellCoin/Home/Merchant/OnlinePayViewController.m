//
//  OnlinePayViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OnlinePayViewController.h"

@interface OnlinePayViewController ()

@property (nonatomic, assign)double xiaofeiJinMoney;

@end

@implementation OnlinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"支付";
    self.merchantName.text = self.dataModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.money];
    [self setPayWay];
}

#pragma mark - 设置支付规则
- (void)setPayWay{
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_scan_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_scan_weixin_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = YES;
    
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
        self.yuELabel.text = [NSString stringWithFormat:@"余额和消费金额不足，请用微信支付"];
        
        self.payWay_type = Payway_type_wechat;
        self.yuEImage.image = [UIImage imageNamed:@"icon_scan_balance_payment_nor"];
        self.wechatImage.image = [UIImage imageNamed:@"icon_scan_weixin_payment_sel"];
        self.yuEMarkBtn.hidden = YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)yuEBtn:(UIButton *)sender {
    
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_scan_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_scan_weixin_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = YES;
}
- (IBAction)wechatBtn:(UIButton *)sender {
    
    self.yuEImage.image = [UIImage imageNamed:@"icon_scan_balance_payment_nor"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_scan_weixin_payment_sel"];
    self.yuEMarkBtn.hidden = YES;
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.yuELabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = NO;
}

- (IBAction)cashBtn:(UIButton *)sender {
    if (self.payWay_type == Payway_type_wechat) {
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
        return;
    }
}
@end

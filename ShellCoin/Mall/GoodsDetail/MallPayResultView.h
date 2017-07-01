//
//  OnlinePayResultView.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Mall_PayTYpe){
    Mall_PayTYpe_wechat = 1,//微信支付
    Mall_PayTYpe_alipay = 2,//支付宝支付
    Mall_PayTYpe_blance = 3,//余额支付
};

@interface MallPayResultView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBill;
- (IBAction)checkBill:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;


@property (nonatomic,assign)Mall_PayTYpe payType;

@end

//
//  OnlinePayResultView.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Merchant_PayTYpe){
    Merchant_PayTYpe_YuE = 1,//余额支付
    Merchant_PayTYpe_Cash = 2,//现金支付
};

@interface OnlinePayResultView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBill;
- (IBAction)checkBill:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;

@property (weak, nonatomic) IBOutlet UIImageView *alerResultImageView;

@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (weak, nonatomic) IBOutlet UIImageView *titleimageView;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic,assign)Merchant_PayTYpe payType;

@end

//
//  WaitApplyView.m
//  ShellCoin
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WaitApplyView.h"
#import "OrderModel.h"

@implementation WaitApplyView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"WaitApplyView" owner:nil options:nil][0];
        self.autResultLabel.adjustsFontSizeToFitWidth = YES;
        self.autResultLabel.numberOfLines = 3;
        self.autResultLabel.textColor = MacoTitleColor;
        if (TWitdh > 320) {
            self.ViewHeight.constant = (TWitdh-100)*(550/520.);
        }else{
            self.ViewHeight.constant = (TWitdh-100)*(650/520.);
        }
        self.autResultTitleLabel.text = self.autResultTitleLabel.text = @"申请处理中";
        self.titleimageView.image = [UIImage imageNamed:@"pic7_personal"];
        self.alerResultImageView.image = [UIImage imageNamed:@"pic8_personal"];
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"pic9_personal"] forState:UIControlStateNormal];
        [self.backBtn setTitle:@"取消申请" forState:UIControlStateNormal];
        self.autResultLabel.text = @"买家正在处理您的申请，请耐心等待。若卖家48小时内未处理，您可通过投诉入口申请帮助。";
    }
    return self;
}

#pragma mark - 取消申请
- (IBAction)backBtn:(id)sender
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"orderId":self.dataModel.orderId};
    [HttpClient POST:@"shop/refund/cancel" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelapplySueecss" object:nil];
            [[JAlertViewHelper shareAlterHelper]showTint:@"取消申请成功" duration:2.];
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];
    }];
}

@end

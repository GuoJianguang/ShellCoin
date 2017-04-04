//
//  OnlinePayResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OnlinePayResultView.h"
#import "BillViewController.h"

@implementation OnlinePayResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"OnlinePayResultView" owner:nil options:nil][0];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autResultLabel.textColor = self.successLabel.textColor = MacoTitleColor;
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 2;
}


- (IBAction)backBtn:(id)sender{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)checkBill:(id)sender {
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.viewController.navigationController pushViewController:billVC animated:YES];
    [self removeFromSuperview];
}
@end

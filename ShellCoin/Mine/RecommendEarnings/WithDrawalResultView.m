//
//  WithDrawalResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WithDrawalResultView.h"

@implementation WithDrawalResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"WithDrawalResultView" owner:nil options:nil][0];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autResultLabel.textColor = self.successLabel.textColor = MacoTitleColor;
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 2;
    if (TWitdh > 320) {
        self.ViewHeight.constant = (TWitdh-100)*(550/520.);
    }else{
        self.ViewHeight.constant = (TWitdh-100)*(650/520.);
        
    }
}

- (void)setIsDicover:(BOOL)isDicover
{
    _isDicover = isDicover;
    if (_isDicover) {
        self.autResultTitleLabel.text = @"提现成功";
        self.successLabel.text = @"提现成功，我们将在2-3个工作日内为您处理";
    }

}
- (IBAction)backBtn:(id)sender{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end

//
//  RealNameAutResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RealNameAutResultView.h"
#import "ManualCertificationViewController.h"


@implementation RealNameAutResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"RealNameAutResultView" owner:nil options:nil][0];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (IBAction)backBtn:(id)sender {
    if (self.isSuccess) {
        [self.viewController.navigationController popViewControllerAnimated:YES];
        return;
    }
    ManualCertificationViewController *manualVC = [[ManualCertificationViewController alloc]init];
    [self.viewController.navigationController pushViewController:manualVC animated:YES];
}


- (void)setIsSuccess:(BOOL)isSuccess
{
    _isSuccess = isSuccess;
    if (self.isSuccess) {
        self.autResultLabel.text = self.autResultTitleLabel.text = @"实名认证成功";
    }else{
        self.autResultLabel.text = self.autResultTitleLabel.text = @"实名认证失败";
    }
    
    
    
}

@end

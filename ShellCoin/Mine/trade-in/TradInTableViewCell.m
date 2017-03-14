//
//  TradInTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TradInTableViewCell.h"
#import "TradInViewController.h"

@implementation TradInTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backBtn:(UIButton *)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
- (IBAction)selcetBankCardBtn:(UIButton *)sender {
    [((TradInViewController *)self.viewController) addBankcardView];
    
    
}
- (IBAction)sureBtn:(UIButton *)sender {
    [((TradInViewController *)self.viewController) sureTardIn];

}
@end

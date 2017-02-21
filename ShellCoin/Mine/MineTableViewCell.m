//
//  MineTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MineTableViewCell.h"
#import "ManagerBankCardViewController.h"
#import "PersonCenterViewController.h"


@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - 点击事件
//消息按钮
- (IBAction)messageBtn:(id)sender {
    
    
}
//条形码按钮
- (IBAction)barCodeBtn:(id)sender {
    
}
//二维码按钮
- (IBAction)qrCodeBtn:(id)sender {
    
}


//帮助
- (IBAction)helpBtn:(id)sender {
}
//抵换
- (IBAction)tradeInBtn:(id)sender {
}

//个人中心
- (IBAction)personCenterAction:(id)sender {
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc]init];
    [self.viewController.navigationController pushViewController:personVC animated:YES];
}

//推荐收益
- (IBAction)recommendEarningsAction:(id)sender {
    
}
//账单
- (IBAction)billAction:(id)sender {
    
}
//设置
- (IBAction)setAction:(id)sender {
    
    
}
@end

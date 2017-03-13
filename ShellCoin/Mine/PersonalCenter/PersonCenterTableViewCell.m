//
//  PersonCenterTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "PersonCenterTableViewCell.h"
#import "ManagerBankCardViewController.h"
#import "RealnameViewController.h"
#import "NoBankCardViewController.h"
#import "MyQrCodeViewController.h"

@interface PersonCenterTableViewCell()

@property (nonatomic, assign)BOOL isHaveBankCard;

@end

@implementation PersonCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImageView.layer.borderWidth = 5;
    self.headImageView.layer.cornerRadius = TWitdh*(10/15.) * (6/10.) /2.;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHead)];
    [self.headImageView addGestureRecognizer:tap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



#pragma mark - 改变头像
- (void)changeHead{
    NSLog(@"changeHead");
}



- (IBAction)backBtn:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
- (IBAction)realNameBtn:(id)sender {
    RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
    [self.viewController.navigationController pushViewController:realnameVC animated:YES];
}
- (IBAction)bankBtn:(id)sender {
    if (self.isHaveBankCard) {
        ManagerBankCardViewController *manageVC = [[ManagerBankCardViewController alloc]init];
        [self.viewController.navigationController pushViewController:manageVC animated:YES];
        return;
    }
    NoBankCardViewController *noBancardVC = [[NoBankCardViewController alloc]init];
    [self.viewController.navigationController pushViewController:noBancardVC animated:YES];
    
}
- (IBAction)vipBtn:(id)sender {
    
    
}
- (IBAction)realNameManageBtn:(id)sender{
    RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
    [self.viewController.navigationController pushViewController:realnameVC animated:YES];
    
}


- (IBAction)qrCodeBtn:(id)sender {
    MyQrCodeViewController *qrCodeVC = [[MyQrCodeViewController alloc]init];
    [self.viewController.navigationController pushViewController:qrCodeVC animated:YES];
}
- (IBAction)mycollectionBtn:(id)sender {
}
@end

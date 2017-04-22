//
//  AboutsUsTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/29.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AboutsUsTableViewCell.h"

@implementation AboutsUsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detail_Label.textColor = MacoTitleColor;
    self.companyLabel.textColor = MacoTitleColor;
    self.visionLabel.text = [NSString stringWithFormat:@"版本号 V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.companyLabel.text =@"成都领创有你科技有限公司\n蜀ICP备17008554号-1";
    self.companyLabel.hidden = ![ShellCoinUserInfo shareUserInfos].isShowPay;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (IBAction)backBtn:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end

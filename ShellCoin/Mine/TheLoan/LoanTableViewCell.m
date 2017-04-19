//
//  LoanTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanTableViewCell.h"

@implementation LoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.progerssView.layer.borderColor = [UIColor colorFromHexString:@"#ffd862"].CGColor;
    self.progerssView.layer.borderWidth = 1;
    self.progerssView.layer.cornerRadius = 5;
    self.progerssView.progressTintColor =MacoColor;
    self.progerssView.layer.masksToBounds = YES;
    self.progerssView.trackTintColor = [UIColor whiteColor];
    
    
    self.progerssView.progress = 0.8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

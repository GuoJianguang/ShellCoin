//
//  SetTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell

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
- (IBAction)exitBtn:(UIButton *)sender {
    
}

- (IBAction)phoneBtn:(id)sender {
    
}
- (IBAction)passwordBtn:(id)sender {
    
}

- (IBAction)cleanBtn:(id)sender {
    
}

- (IBAction)aboutUsBtn:(id)sender {
    
}
@end

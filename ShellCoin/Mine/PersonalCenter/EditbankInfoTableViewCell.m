//
//  EditbankInfoTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditbankInfoTableViewCell.h"
#import "Colours.h"


@implementation EditbankInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.upViewHeight.constant = (TWitdh-30)*(55/278.)*6 + 20 + 6*8;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    [self setLayerWithbor:self.view5];
    [self setLayerWithbor:self.view6];
    [self setLayerWithbor:self.view7];
    [self setLayerWithbor:self.view8];
    
    self.view7.hidden = self.view8.hidden = YES;

}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selcetZHNumBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.upViewHeight.constant = (TWitdh-30)*(55/278.)*4 + 20 + 4*8;
        self.view6.hidden = self.view5.hidden = YES;
        self.view7.hidden = self.view8.hidden = NO;

    }else{
        self.upViewHeight.constant = (TWitdh-30)*(55/278.)*6 + 20 + 4*8;
        self.view6.hidden = self.view5.hidden = NO;
        self.view7.hidden = self.view8.hidden = YES;
    }
    
    
}
@end

//
//  HomeMerchantTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeMerchantTableViewCell.h"

@implementation HomeMerchantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headIamgeView.layer.cornerRadius = (TWitdh*(95/320.) - 15 - 20)/2.;
    self.headIamgeView.layer.masksToBounds = YES;
    self.title_label.textColor = MacoTitleColor;
    self.detail_label.textColor = MacoDetailColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(RecommentModel *)dataModel
{
    _dataModel = dataModel;
}

@end

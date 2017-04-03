//
//  ForyouCollectionViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ForyouCollectionViewCell.h"

@implementation ForyouCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.markBtn.layer.cornerRadius = 11.;
    self.markBtn.layer.masksToBounds = YES;
    self.nameLabel.textColor = MacoTitleColor;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.layer.masksToBounds = YES;
}

@end

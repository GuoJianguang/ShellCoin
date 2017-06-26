//
//  MallSortCollectionViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallSortCollectionViewCell.h"

@implementation MallSortCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.itemBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
    self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    self.itemBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}


- (void)setDataModel:(NewHomeActivityModel *)dataModel
{
    _dataModel = dataModel;
    [self.itemBtn setTitle:_dataModel.name forState:UIControlStateNormal];
    if (_dataModel.isSelect) {
        self.itemBtn.layer.cornerRadius = 4;
        self.itemBtn.layer.borderWidth = 1;
        self.itemBtn.layer.borderColor = MacoColor.CGColor;
        [self.itemBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    }else{
        self.itemBtn.layer.cornerRadius = 0;
        self.itemBtn.layer.borderWidth = 0;
        [self.itemBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    }
}


@end

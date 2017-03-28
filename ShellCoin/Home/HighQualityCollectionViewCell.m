//
//  HighQualityCollectionViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HighQualityCollectionViewCell.h"

@interface HighQualityCollectionViewCell()

@end

@implementation HighQualityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(PopularMerModel *)dataModel
{
    _dataModel = dataModel;
    [self.merchantImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageCircular];
    self.name.text = _dataModel.mchName;
}

@end

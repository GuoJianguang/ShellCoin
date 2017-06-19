//
//  MallGoodsCollectionViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallGoodsCollectionViewCell.h"

@implementation MallGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.goodsName.textColor = [UIColor colorFromHexString:@"#282828"];
    self.goodsPrice.textColor = MacoColor;
    self.goodsSales.textColor = [UIColor colorFromHexString:@"#817f7f"];

}

@end

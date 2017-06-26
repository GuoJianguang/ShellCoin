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

- (void)setDataModel:(MallGoodsModel *)dataModel
{
    _dataModel = dataModel;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.coverImage] placeholderImage:LoadingErrorDefaultImageSquare];
    self.goodsName.text = _dataModel.name;
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",_dataModel.price];
    self.goodsSales.text = [NSString stringWithFormat:@"销量:%@件",_dataModel.saleCount];
    if ([_dataModel.recommend isEqualToString:@"1"]) {
        self.commendIamge.hidden = NO;
    }else{
        self.commendIamge.hidden = YES;

    }
}

@end

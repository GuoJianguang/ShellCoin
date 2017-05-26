//
//  DiscoverCollectionViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//



#import "DiscoverCollectionViewCell.h"

@implementation DiscoverGoodsModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    DiscoverGoodsModel *model = [[DiscoverGoodsModel alloc]init];
    model.goodsId   = NullToSpace(dic[@"id"]);
    model.coverImage   = NullToSpace(dic[@"coverImage"]);
    model.name   = NullToSpace(dic[@"name"]);
    model.price   = NullToNumber(dic[@"price"]);
    model.saleCount   = NullToNumber(dic[@"saleCount"]);
    model.htmlUrl = NullToSpace(dic[@"detailUrl"]);
    return model;
}

@end


@implementation DiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)setDataModel:(DiscoverGoodsModel *)dataModel
{
    _dataModel = dataModel;
    self.goodsName.text = _dataModel.name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.coverImage] placeholderImage:LoadingErrorDefaultImageSquare];

    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",_dataModel.price];
}


@end

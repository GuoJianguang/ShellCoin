//
//  MallGoodsModel.m
//  ShellCoin
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallGoodsModel.h"

@implementation MallGoodsModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MallGoodsModel *model = [[MallGoodsModel alloc]init];
    model.coverImage = NullToSpace(dic[@"coverImage"]);
    model.detailUrl = NullToSpace(dic[@"detailUrl"]);
    model.goodsId = NullToSpace(dic[@"id"]);
    model.name = NullToSpace(dic[@"name"]);
    model.price = NullToSpace(dic[@"price"]);
    model.saleCount = NullToNumber(dic[@"saleCount"]);
    model.recommend = NullToNumber(dic[@"recommend"]);
    return model;
}

@end

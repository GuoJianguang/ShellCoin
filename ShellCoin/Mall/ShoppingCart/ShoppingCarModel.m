//
//  ShoppingCarModel.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoppingCarModel.h"

@implementation ShoppingCarModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ShoppingCarModel *model = [[ShoppingCarModel alloc]init];
//    model.goodsName = NullToSpace(dic[@"goodsName"]);
//    model.pic = NullToSpace(dic[@"pic"]);
//    model.goodsSpec = NullToSpace(dic[@"goodsSpec"]);
//    model.goodsDetail = NullToSpace(dic[@"goodsDetail"]);
//    model.goodsNum = NullToSpace(dic[@"goodsNum"]);

    return model;
}

+ modelWithCoreData:(ShoopingCart *)cartDic
{
    ShoppingCarModel *model = [[ShoppingCarModel alloc]init];
    model.goodsName = cartDic.goodsName;
    model.pic = cartDic.goodsImage;
    model.goodsSpec = cartDic.goodsSpec;
    model.cash = cartDic.cash;
    model.shellCoin = cartDic.shellCoin;
    model.coupons = cartDic.coupons;
    model.goodsNum = cartDic.goodsNum;
    model.goodsPrice = cartDic.goodsPrice;
    model.goodsFreight = cartDic.goodsFreight;
    model.goodsId = cartDic.goodsId;
    model.priceId = cartDic.priceId;
    return model;
}
@end

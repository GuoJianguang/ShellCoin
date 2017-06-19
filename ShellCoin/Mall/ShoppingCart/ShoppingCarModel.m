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
    model.goodsName = NullToSpace(dic[@"goodsName"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.goodsSpec = NullToSpace(dic[@"goodsSpec"]);
    model.goodsDetail = NullToSpace(dic[@"goodsDetail"]);
    model.goodsNum = NullToSpace(dic[@"goodsNum"]);

    return model;
}

@end

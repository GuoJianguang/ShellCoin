//
//  OrderModel.m
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    OrderModel *model = [[OrderModel alloc]init];
    model.orderId = NullToSpace(dic[@"id"]);
    return model;
}

@end

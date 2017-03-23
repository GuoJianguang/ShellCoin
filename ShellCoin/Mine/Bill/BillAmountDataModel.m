//
//  BillAmountDataModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillAmountDataModel.h"

@implementation BillAmountDataModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BillAmountDataModel *model = [[BillAmountDataModel alloc]init];
    model.orderId = NullToSpace(dic[@"orderId"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.mchCode = NullToSpace(dic[@"mchCode"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.channel = NullToSpace(dic[@"channel"]);
    model.state = NullToNumber(dic[@"state"]);
    model.userId = NullToSpace(dic[@"userId"]);
    return model;
}

@end

@implementation BillDihuanModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BillDihuanModel *model = [[BillDihuanModel alloc]init];
    model.orderId = NullToSpace(dic[@"id"]);
    model.withdrawAmout = NullToSpace(dic[@"withdrawAmount"]);
    model.successTime = NullToSpace(dic[@"successTime"]);
    model.state = NullToSpace(dic[@"state"]);
    return model;
    
}

@end

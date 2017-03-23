//
//  BillIntegaralModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillIntegaralModel.h"

@implementation BillIntegaralModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BillIntegaralModel *model = [[BillIntegaralModel alloc]init];
    model.integaralId = NullToSpace(dic[@"id"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.time = NullToSpace(dic[@"time"]);
    model.accumulateAmount = NullToSpace(dic[@"accumulateAmount"]);
    model.tranAmount = NullToSpace(dic[@"tranAmount"]);
    model.tranType = NullToNumber(dic[@"tranType"]);
    return model;
}
@end


@implementation IntegralShellCoinModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    IntegralShellCoinModel *model = [[IntegralShellCoinModel alloc]init];
    model.integaralId = NullToSpace(dic[@"id"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    model.time = NullToSpace(dic[@"time"]);
    model.shellsAmount = NullToSpace(dic[@"shellsAmount"]);
    model.tranAmount = NullToSpace(dic[@"tranAmount"]);
    model.tranType = NullToNumber(dic[@"tranType"]);
    return model;
}

@end

//
//  BillDataModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillDataModel.h"

@implementation BillDataModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BillDataModel *model = [[BillDataModel alloc]init];
    model.balanceAmount = NullToNumber(dic[@"balanceAmount"]);
    model.cashAmount = NullToNumber(dic[@"cashAmount"]);
    model.consumeAmount = NullToNumber(dic[@"consumeAmount"]);
    
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.channel = NullToNumber(dic[@"channel"]);
    model.goodsName = NullToSpace(dic[@"goodsName"]);
    model.spec = NullToSpace(dic[@"spec"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.mchCode = NullToSpace(dic[@"mchCode"]);
    model.payType = NullToNumber(dic[@"payType"]);
    model.state = NullToNumber(dic[@"state"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    return model;
}


@end

@implementation TixianModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    TixianModel *model = [[TixianModel alloc]init];
    model.tixianId = NullToSpace(dic[@"id"]);
    model.withdrawAmout = NullToNumber(dic[@"withdrawAmout"]);
    model.successTime = NullToSpace(dic[@"successTime"]);
    model.state = NullToNumber(dic[@"state"]);
    return model;
}

@end

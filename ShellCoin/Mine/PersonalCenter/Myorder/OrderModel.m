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
    
    model.detailId = NullToSpace(dic[@"detailId"]);

    model.goodsId = NullToSpace(dic[@"goodsId"]);

    model.goodsName = NullToSpace(dic[@"goodsName"]);

    model.goodsImage = NullToSpace(dic[@"goodsImage"]);

    model.goodsSpecDesc = NullToSpace(dic[@"goodsSpecDesc"]);

    model.quantity = NullToNumber(dic[@"quantity"]);

    model.goodsPrice = NullToNumber(dic[@"goodsPrice"]);

    model.state = NullToNumber(dic[@"state"]);

    model.logisticsNumber = NullToSpace(dic[@"logisticsNumber"]);

    model.mchName = NullToSpace(dic[@"mchName"]);

    model.logisticsCompany = NullToSpace(dic[@"logisticsCompany"]);

    model.logisticsCompanyCode = NullToSpace(dic[@"logisticsCompanyCode"]);

    model.commentFlag = NullToNumber(dic[@"commentFlag"]);

    model.freight = NullToNumber(dic[@"freight"]);

    model.priceId = NullToNumber(dic[@"priceId"]);

    model.mchCode = NullToSpace(dic[@"mchCode"]);

    model.receiptAddress = NullToSpace(dic[@"receiptAddress"]);

    model.receiptPeople = NullToSpace(dic[@"receiptPeople"]);
    model.receiptPhone = NullToSpace(dic[@"receiptPhone"]);

    model.tranAmount = NullToNumber(dic[@"tranAmount"]);

    model.consumeAmount = NullToNumber(dic[@"consumeAmount"]);
    model.expectAmount = NullToNumber(dic[@"expectAmount"]);

    return model;
}

@end

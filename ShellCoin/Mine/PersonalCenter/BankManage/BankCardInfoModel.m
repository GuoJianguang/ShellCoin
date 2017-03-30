//
//  BankCardInfoModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/30.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BankCardInfoModel.h"

@implementation BankCardInfoModel

+(id)modelWithDic:(NSDictionary *)dic
{
    BankCardInfoModel *model = [[BankCardInfoModel alloc]init];
    model.bankinfoid = NullToSpace(dic[@"id"]);
    model.bankAccount = NullToSpace(dic[@"bankAccount"]);
    model.bankPhone = NullToSpace(dic[@"bankPhone"]);
    model.realName = NullToSpace(dic[@"realName"]);
    model.identity = NullToSpace(dic[@"identity"]);
    model.bankBranch = NullToSpace(dic[@"bankBranch"]);
    model.bankBranchNo = NullToSpace(dic[@"bankBranchNo"]);
    model.bankAccountPro = NullToSpace(dic[@"bankAccountPro"]);
    model.bankId = NullToSpace(dic[@"bankId"]);
    model.bankName = NullToSpace(dic[@"bankName"]);
    model.bankPoint = NullToSpace(dic[@"bankPoint"]);
    model.bankPointBranch = NullToSpace(dic[@"bankPointBranch"]);
    model.state = NullToSpace(dic[@"state"]);

    return model;
}

@end

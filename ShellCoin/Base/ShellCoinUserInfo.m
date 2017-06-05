//
//  ShellCoinUserInfo.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShellCoinUserInfo.h"

static ShellCoinUserInfo *instance;


@implementation ShellCoinUserInfo

+ (ShellCoinUserInfo *)shareUserInfos
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ShellCoinUserInfo alloc]init];
    });
    return instance;
}

- (void)setUserinfoWithdic:(NSDictionary *)dic
{
//    instance.token = NullToSpace(dic[@"token"]);
//    instance.userId = NullToSpace(dic[@"id"]);
//    instance.shellsAmount = NullToNumber(dic[@"shellsAmount"]);
//    instance.nickName = NullToSpace(dic[@"nickName"]);
//    instance.vipLevel = NullToNumber(dic[@"vipLevel"]);
//    instance.password = NullToSpace(dic[@"password"]);
    instance.payPassword = NullToSpace(dic[@"payPassword"]);
//    instance.recommendAmount = NullToSpace(dic[@"recommendAmount"]);
//    
//    if ([NullToNumber(dic[@"idVerifyReqFlag"]) isEqualToString:@"1"]) {
//        instance.idVerifyReqFlag = YES;
//    }else{
//        instance.idVerifyReqFlag = NO;
//    }
//    if ([NullToNumber(dic[@"bindingFlag"]) isEqualToString:@"1"]) {
//        instance.bindingFlag = YES;
//    }else{
//        instance.bindingFlag = NO;
//    }
//    instance.totalAccumulateAmount  = NullToNumber(dic[@"totalAccumulateAmount "]);
//    /*
//     userRebateVo
//    */
//    instance.rebateShellsAmount = NullToNumber(dic[@"rebateShellsAmount"]);
//    instance.totalRate = NullToNumber(dic[@"totalRate"]);
//    instance.baseRate = NullToNumber(dic[@"baseRate"]);
//    instance.plusRate = NullToNumber(dic[@"plusRate"]);
//    if ([dic[@"userRebateVo"] isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *unreadMsgCountVo = dic[@"userRebateVo"];
//        instance.rebateShellsAmount = NullToNumber(unreadMsgCountVo[@"rebateShellsAmount"]);
//        instance.totalRate = NullToNumber(unreadMsgCountVo[@"totalRate"]);
//        instance.baseRate = NullToNumber(unreadMsgCountVo[@"baseRate"]);
//        instance.plusRate = NullToNumber(unreadMsgCountVo[@"plusRate"]);
//    }
//    
    
    
#pragma mark - 老数据
    instance.avatar = NullToSpace(dic[@"avatar"]);
    instance.vipLevel = NullToNumber(dic[@"vipLevel"]);
    instance.vipRate = NullToSpace(dic[@"vipRate"]);
    instance.currentTotalAmount = [NullToNumber(dic[@"currentTotalAmount"]) integerValue];
    instance.nextLevelAmount = [NullToNumber(dic[@"nextLevelAmount"]) integerValue];
    instance.aviableBalance = NullToNumber(dic[@"aviableBalance"]);
    instance.city = NullToSpace(dic[@"city"]);
    instance.userid = NullToSpace(dic[@"id"]);
    instance.nickName = NullToSpace(dic[@"nickName"]);
    instance.province = NullToSpace(dic[@"province"]);
    instance.token = NullToSpace(dic[@"token"]);
    instance.totalConsumeAmount = NullToNumber(dic[@"totalConsumeAmount"]);
    instance.totalExpectAmount = NullToNumber(dic[@"totalExpectAmount"]);
    instance.zone = NullToSpace(dic[@"zone"]);
    instance.phone = NullToSpace(dic[@"phone"]);
    
    if ([NullToNumber(dic[@"bindingFlag"]) isEqualToString:@"1"]) {
        instance.bindingFlag = YES;
    }else{
        instance.bindingFlag = NO;
    }
    instance.grade = NullToNumber(dic[@"grade"]);
    instance.integral = NullToNumber(dic[@"integral"]);
    instance.bankAccount = NullToSpace(dic[@"bankAccount"]);
    instance.bankAccountRealName = NullToSpace(dic[@"bankAccountRealName"]);
    
    instance.completeCount = NullToNumber(dic[@"completeCount"]);
    instance.totalWaitCount = NullToNumber(dic[@"totalWaitCount"]);
    instance.messageCount = NullToNumber(dic[@"messageCount"]);
    instance.withdrawCount = NullToNumber(dic[@"withdrawCount"]);
    instance.feedbackCount = NullToNumber(dic[@"feedbackCount"]);
    instance.orderCount = NullToNumber(dic[@"orderCount"]);
    instance.waitDeleverCount = NullToNumber(dic[@"waitDeleverCount"]);
    instance.waitConfirmCount = NullToNumber(dic[@"waitConfirmCount"]);
    instance.unPayOrderCount = NullToNumber(dic[@"unPayOrderCount"]);
    instance.idcard = NullToSpace(dic[@"idcard"]);
    instance.idcardName = NullToSpace(dic[@"idcardName"]);
    instance.consumeBalance = NullToNumber(dic[@"consumeBalance"]);
    
    
    NSString *notPay = NullToNumber(dic[@"notConsumeDays"]);
    instance.notConsumeDays = [notPay integerValue];
    if ([NullToNumber(dic[@"identityFlag"]) isEqualToString:@"1"]) {
        instance.identityFlag = YES;
    }else{
        instance.identityFlag = NO;
    }
    
    if ([NullToNumber(dic[@"idVerifyReqFlag"]) isEqualToString:@"1"]) {
        instance.idVerifyReqFlag = YES;
    }else{
        instance.idVerifyReqFlag = NO;
    }
    
    if ([NullToNumber(dic[@"payPwdFlag"]) isEqualToString:@"1"]) {
        instance.payPwdFlag = NO;
    }else if([NullToNumber(dic[@"payPwdFlag"]) isEqualToString:@"2"]){
        instance.payPwdFlag = YES;

    }
    instance.wiatJoinAmunt = NullToNumber(dic[@"waitJoinAmount"]);
    instance.lastRebateBalance = NullToNumber(dic[@"lastRebateBalance"]);
    instance.lastRebateConsumeBalance = NullToNumber(dic[@"lastRebateConsumeBalance"]);

    if ([dic[@"unreadMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *unreadMsgCountVo = dic[@"unreadMsgCountVo"];
        instance.feedbackCount = NullToNumber(unreadMsgCountVo[@"feedbackCount"]);
        instance.messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
        //        instance.orderCount = NullToNumber(unreadMsgCountVo[@"orderCount"]);
        instance.withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
        instance.waitDeleverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
        instance.waitConfirmCount = NullToNumber(unreadMsgCountVo[@"waitConfirmCount"]);
        instance.unPayOrderCount = NullToNumber(unreadMsgCountVo[@"unPayorderCount"]);
        instance.completeCount = NullToNumber(unreadMsgCountVo[@"completeCount"]);
        instance.totalWaitCount = NullToNumber(unreadMsgCountVo[@"totalWaitCount"]);
    }

}


- (NSString *)locationCity
{
    if (!_locationCity) {
        _locationCity = [NSString string];
        _locationCity = @"";
    }
    return _locationCity;
}

@end

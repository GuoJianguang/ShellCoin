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
    
}

@end

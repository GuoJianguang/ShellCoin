//
//  ShellCoinUserInfo.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShellCoinUserInfo : NSObject

+ (ShellCoinUserInfo *)shareUserInfos;

@property (nonatomic, assign)BOOL currentLogined;
@property (nonatomic, copy)NSString *devicetoken;

@property (nonatomic, copy)NSString *token;

- (void)setUserinfoWithdic:(NSDictionary *)dic;

@end

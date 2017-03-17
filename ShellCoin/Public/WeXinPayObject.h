//
//  WeXinPayObject.h
//  tiantianxin
//
//  Created by ttx on 16/4/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface WeXinPayObject : NSObject<WXApiDelegate>

+ (WeXinPayObject *)shareWexinPayObject;

//商城购买商品的时候发起的支付请求
+ (void)startWexinPay:(NSDictionary *)parms;

//商家在线支付的时候发起的支付请求

+ (void)srarMachantWexinPay:(NSDictionary *)parms;


//爱心账户充值

+ (void)loveAcountWexinPay:(NSDictionary *)parms;

@end

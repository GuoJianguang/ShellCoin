//
//  AliPayObject.h
//  ShellCoinForMerchant
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliPayObject : NSObject
+ (AliPayObject *)shareAliPayObject;
//发现调起支付宝
+ (void)startAliPayDiscoverPay:(NSDictionary *)parms;
//商家在线支付
+ (void)startAliPayMerchantOnlinePay:(NSDictionary *)parms;
//商城在线支付
+ (void)startAliPayMallPay:(NSDictionary *)parms;

@end

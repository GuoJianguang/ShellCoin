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
@end

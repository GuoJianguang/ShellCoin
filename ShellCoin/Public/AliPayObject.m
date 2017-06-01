//
//  AliPayObject.m
//  ShellCoinForMerchant
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AliPayObject.h"
#import <AlipaySDK/AlipaySDK.h>


static AliPayObject *instance;

@interface AliPayObject()

@end

@implementation AliPayObject

+ (AliPayObject *)shareAliPayObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AliPayObject alloc]init];
    });
    return instance;
}

+ (void)startAliPayDiscoverPay:(NSDictionary *)parms
{
    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"pay/find/alipay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSString *jsonorderString = NullToSpace(jsonObject[@"data"][@"orderString"]);
            if (![jsonorderString isEqualToString:@""]) {
                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                NSString *appScheme = @"ShellCoinForCoumer";
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                         orderInfoEncoded, jsonorderString];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:jsonorderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:AliPayResult object:nil userInfo:resultDic];


                }];
            }

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:2.];
    }];
    
}


+ (void)startAliPayMerchantOnlinePay:(NSDictionary *)parms
{
    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"pay/mch/alipay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSString *jsonorderString = NullToSpace(jsonObject[@"data"][@"orderString"]);
            if (![jsonorderString isEqualToString:@""]) {
                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                NSString *appScheme = @"ShellCoinForCoumer";
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                //                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                //                                         orderInfoEncoded, jsonorderString];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:jsonorderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:AliPayResult object:nil userInfo:resultDic];
                    
                }];
            }
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:2.];
    }];
    

    
}


@end

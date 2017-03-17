//
//  WeXinPayObject.m
//  tiantianxin
//
//  Created by ttx on 16/4/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WeXinPayObject.h"



static WeXinPayObject *instance;

@interface WeXinPayObject()

@end

@implementation WeXinPayObject


+ (WeXinPayObject *)shareWexinPayObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WeXinPayObject alloc]init];
    });
    return instance;
}



+ (void)startWexinPay:(NSDictionary *)parms
{

    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"pay/wxpay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSDictionary *dict = jsonObject[@"data"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req] ;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:1.];
    }];
}




+ (void)srarMachantWexinPay:(NSDictionary *)parms
{
    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"pay/mch/wxpay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSDictionary *dict = jsonObject[@"data"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req] ;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:1.];
    }];
}

#pragma mark -  爱心账户充值
+ (void)loveAcountWexinPay:(NSDictionary *)parms
{
    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"pay/user/donate/wxpay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSDictionary *dict = jsonObject[@"data"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req] ;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:1.];
    }];
    
}



- (void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response= (PayResp*)resp;
        NSDictionary *dic = @{@"resultcode":[NSString stringWithFormat:@"%d",response.errCode]};
        [[NSNotificationCenter defaultCenter]postNotificationName:WeixinPayResult object:nil userInfo:dic];

        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}

@end

//
//  HttpClient.m
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//


#import "HttpClient.h"
#import <CommonCrypto/CommonDigest.h>


@implementation HttpClient

+(void)addTokenWithParameter:(NSMutableDictionary *)parameters manager:(AFHTTPSessionManager *)manager {
    
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
}

+(void)handleWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(NSURLSessionDataTask *, id))success {
    [super handleWithOperation:operation responseObject:responseObject success:success];
}

//+(void)failureHandleWithOperation:(NSURLSessionDataTask *)operation error:(NSError *)error callBack:(void (^)(NSURLSessionDataTask *, NSError *))failure{
//    
//    [super failureHandleWithOperation:operation error:error callBack:failure];
//    
//    // 返回的错误码
//    NSInteger errorCode = operation.response.statusCode;
//    if (errorCode == 400) {
//    
//    }
//    // 数据没有发生变化
//    else if (errorCode == 301) {
//        
//    }
//}

+(void)additionalOperatingWithManager:(AFHTTPSessionManager *)manager parameter:(NSMutableDictionary *)parameters {

    [[self class] manager:manager addSignAndKeyWithParameter:parameters];
}


+(AFHTTPSessionManager*) manager:(AFHTTPSessionManager*)manager addSignAndKeyWithParameter:(id)parameters {
    NSString *sign = [[self class] signWithParameter:parameters appKey:APP_KEY secret:APP_SECRET];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:APP_KEY forHTTPHeaderField:@"appkey"];
    return manager;
}

+(NSString*) signWithParameter:(id) parameter appKey:(NSString*) appKey secret:(NSString*)secret {
    
    NSMutableDictionary *paraWithAppkey = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [paraWithAppkey setObject:APP_KEY forKey:@"appkey"];
    NSArray *array = [paraWithAppkey allKeys];
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *signString = [[NSMutableString alloc] initWithString:secret];
    for (NSString *key in sortedArray) {
        NSString *value = [paraWithAppkey objectForKey:key];
        if (value && key) {
            [signString appendString:key];
            [signString appendString:[value description]];
        }
    }
    NSString *md5_string = [signString md5_32];
    return [md5_string uppercaseString];
}


+(NSMutableDictionary*) addSequenceAndSourceToParameter:(id) parameters {
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [para setObject:[[self class] seq] forKey:@"seq"];
    [para setObject:@"2" forKey:@"source"];
    return para;
}


+(NSString*) seq {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormatterString];
    NSString *string = [formatter stringFromDate:date];
    NSString *strRandom = @"";
    for(int i=0; i< 6; i++)
    {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return [string stringByAppendingString:strRandom];
}

@end

@implementation NSString(MD5)

-(NSString *)md5_32{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [output uppercaseString];
}

@end

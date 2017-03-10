//
//  BaseHttpClient.m
//  TeacherResponder
//
//  Created by tongbu_jinzhongjun on 14/11/6.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import "BaseHttpClient.h"
#import "HttpClientAlertViewHelper.h"
#import "AppDelegate.h"

#define NullToSpace(string) (([string class] != [NSNull class] && string) ? [string description]: @"")
#define NullToNumber(string) (([string class] != [NSNull class] && string) ? [string description]: @"0")

@interface BaseHttpClient()

@end

@implementation BaseHttpClient

+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *fullUrlString = [[self class] fullUrlWith:URLString];
    return [[self class] POSTWithFullUrl:fullUrlString parameters:parameters success:success failure:failure];
}

+(NSURLSessionDataTask *)POSTWithFullUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    Class class = [self class];
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"213955937960616" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [securityPolicy setPinnedCertificates:certSet];
//    [securityPolicy setValidatesDomainName:NO];
    //    manager.securityPolicy = securityPolicy;
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    
    return [manager POST:URLString parameters:mutalbleParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class] handleWithOperation:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self class] failureHandleWithOperation:task error:error callBack:failure];
    }];
}

+(NSURLSessionDataTask *)POST:(NSString *)URLString header:(id)headerPara body:(id)bodyPara success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *fullUrlString = [[self class] fullUrlWith:URLString];
    return [self POSTWithFullUrl:fullUrlString header:headerPara body:bodyPara success:success failure:failure];
}

+(NSURLSessionDataTask *)POSTWithFullUrl:(NSString *)URLString header:(id)headerPara body:(id)bodyPara success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    Class class = [self class];
    AFHTTPSessionManager *manager = [class defaultManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSArray *keys = [headerPara allKeys];
    for (NSString *key in keys) {
        [manager.requestSerializer setValue:[headerPara valueForKey:key] forHTTPHeaderField:key];
    }
    
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:bodyPara];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    
    return [manager POST:URLString parameters:mutalbleParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class] handleWithOperation:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self class] failureHandleWithOperation:task error:error callBack:failure];
        
    }];
}

+(NSURLSessionDataTask *)GETWithFullUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    Class class = [self class];

    AFHTTPSessionManager *manager = [class defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    
    return  [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class]handleWithOperation:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self class] failureHandleWithOperation:task error:error callBack:failure];
    }];
    

}

+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *fullUrlString = [[self class] fullUrlWith:URLString];
    
    return [self GETWithFullUrl:fullUrlString parameters:parameters success:success failure:failure];
}


+(NSURLSessionDataTask *)GET:(NSString *)URLString header:(id)headerPara body:(id)bodyPara success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    Class class = [self class];
    return  [class GETWithFullUrl:[class fullUrlWith:URLString] header:headerPara body:bodyPara success:success failure:failure];
    
}


+(NSURLSessionDataTask *)GETWithFullUrl:(NSString *)URLString header:(id)headerPara body:(id)bodyPara success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    Class class = [self class];
    AFHTTPSessionManager *manager = [class defaultManager];
    NSArray *keys = [headerPara allKeys];
    for (NSString *key in keys) {
        [manager.requestSerializer setValue:[headerPara valueForKey:key] forHTTPHeaderField:key];
    }
    
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:bodyPara];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    
    
    return [manager GET:URLString parameters:mutalbleParameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class] handleWithOperation:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self class] failureHandleWithOperation:task error:error callBack:failure];

    }];

}


#pragma mark -  带入token

+(NSURLSessionDataTask *)POSTWithToken:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *fullUrlString = [[self class] fullUrlWith:URLString];
    Class class = [self class];
    AFHTTPSessionManager *manager = [class defaultManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [class addTokenWithParameter:mutalbleParameter manager:manager];
    
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    
    return [manager POST:fullUrlString parameters:mutalbleParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class] handleWithOperation:task responseObject:responseObject success:success];

    } failure:failure];

}

+(NSURLSessionDataTask *)GETWithToken:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *fullUrlString = [[self class] fullUrlWith:URLString];
    Class class = [self class];
    
    AFHTTPSessionManager *manager = [class defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [class addTokenWithParameter:mutalbleParameter manager:manager];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    return [manager GET:fullUrlString parameters:mutalbleParameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self class] handleWithOperation:task responseObject:responseObject success:success];

    } failure:failure];
}
#pragma mark - 上传图片
///*
// *  带token 的请求.默认 不做任何实现
// *  根据实际情况进行实现。
// *  token的处理方式请实现 HttpClient 中的 +(void)addTokenWithParameter: manager: 方法
// *
// */

+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                       images:(NSArray*) images
                      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Class class = [self class];
    NSString *fullUrlString = [class fullUrlWith:URLString];
    AFHTTPSessionManager *manager = [class defaultManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];    
    return  [manager POST:fullUrlString parameters:mutalbleParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < [images count]; i++) {
            UIImage *image = [images objectAtIndex:i];
            NSString *imageSuffix = @"jpg";
            NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
                imageSuffix = @"png";
            }
            
            [formData appendPartWithFileData:imageData name:@"upload" fileName:[NSString stringWithFormat:@"image2222%d.%@",i,imageSuffix] mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];

}

+(NSURLSessionDataTask *)POSTWithToken:(NSString *)URLString parameters:(id)parameters images:(NSArray *)images success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    Class class = [self class];
    NSString *fullUrlString = [class fullUrlWith:URLString];
    AFHTTPSessionManager *manager = [class defaultManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [class additionalOperatingWithManager:manager parameter:mutalbleParameter];
    [class addTokenWithParameter:mutalbleParameter manager:manager];
    
    return  [manager POST:fullUrlString parameters:mutalbleParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < [images count]; i++) {
            UIImage *image = [images objectAtIndex:i];
            NSString *imageSuffix = @"jpg";
            NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
                imageSuffix = @"png";
            }
            
            [formData appendPartWithFileData:imageData name:@"upload" fileName:[NSString stringWithFormat:@"image2222%d.%@",i,imageSuffix] mimeType:@"image/jpeg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];
    
    //老方法已弃用
//    return [manager POST:fullUrlString parameters:mutalbleParameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        
//        for (int i = 0; i < [images count]; i++) {
//            UIImage *image = [images objectAtIndex:i];
//            NSString *imageSuffix = @"jpg";
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
//            if (!imageData) {
//                imageData = UIImagePNGRepresentation(image);
//                imageSuffix = @"png";
//            }
//            
//            [formData appendPartWithFileData:imageData name:@"upload" fileName:[NSString stringWithFormat:@"image2222%d.%@",i,imageSuffix] mimeType:@"image/jpeg"];
//        }
//    } success:success failure:failure];
}



#pragma mark - 上传和下载文件

+(void)uploadFileAtPath:(NSString*)filePath toUrl:(NSString *)urlString
               progress:(NSProgress*)progress completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLSessionDataTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:fileUrl progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:completionHandler];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:fileUrl progress:&progress completionHandler:completionHandler];
    [uploadTask resume];
}

+(void)uploadFiles:(NSData *)data toUrl:(NSString *)urlString progress:(NSProgress *)progress completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSessionDataTask *uploadTask = [manager uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:completionHandler];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:data progress:&progress completionHandler:completionHandler];
    [uploadTask resume];
}

+(void)downloadWithUrl:(NSString *)urlString fileName:(NSString *)fileName downloadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadBlock success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    [[self class] downloadWithUrl:urlString fileName:fileName needUnzip:NO downloadBlock:downloadBlock success:success failure:failure];
}


+(AFHTTPSessionManager*) defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.stringEncoding = RequestSerializerEncoding;
    requestSerializer.timeoutInterval = TimeoutInterval;
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.stringEncoding = ResponseSerializerEncoding;
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    return manager;
}


+(void) handleWithOperation:(NSURLSessionDataTask*)operation responseObject:(id) responseObject success:(void (^)(NSURLSessionDataTask *, id))success
{
    @try {
        NSError *error = nil;
        //    id jsonObject = [responseObject objectFromJSONData];//
        id jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:ResponseSerializerEncoding];
        NSString *err_string = [NSString stringWithFormat:@"json 格式错误.返回字符串：%@",responseString];
        NSAssert(error==nil, err_string);
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            if([NullToNumber(jsonObject[@"code"]) isEqualToString:@"-300"]) {
//                [TTXUserInfo shareUserInfos].currentLogined = NO;
//                [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch];
//                [[NSUserDefaults standardUserDefaults]synchronize];
                UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"账号登录已过期或已在其他设备上登录,请重新登录" delegate:[UIApplication sharedApplication].keyWindow.rootViewController cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
                [aler show];
                success(operation,jsonObject);
                return;
            }
            if (![NullToNumber(jsonObject[@"code"]) isEqualToString:@"0"]) {
//                [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:1.5];
                [[HttpClientAlertViewHelper sharedAlterHelper]showTint:jsonObject[@"message"] duration:2.0];
            }
        }
        success(operation,jsonObject);
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

+(void) failureHandleWithOperation:(NSURLSessionDataTask *)operation error:(NSError*)error callBack:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    // 检测有无网络
     AFNetworkReachabilityManager *reachManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachManager.reachable) {

        NSDictionary *userInfor = error.userInfo;
        NSString *domain = error.domain;
        NSInteger code = error.code;
        NSMutableDictionary *newErrorInfor = [NSMutableDictionary dictionaryWithDictionary:userInfor];
        [newErrorInfor setObject:@"无网络连接..." forKey:@"response"];
        NSError *newError = [NSError errorWithDomain:domain code:code userInfo:newErrorInfor];
        failure(operation,newError);
        return;
    }
    NSString *errorString = [error.userInfo objectForKey:TimeoutErrorKey];
    if([errorString isEqualToString:TimeoutErrorValue]){
        if (ShowErrorMessage) {
             [[HttpClientAlertViewHelper sharedAlterHelper] showTint:TimeoutErrorTintString duration:1.5f];
        }
    }else if ([errorString isEqualToString:CouldNotConnectServerValue] || [errorString isEqualToString:TimeoutErrorValue] || [errorString isEqualToString:@"未能连接到服务器。"]) {
        [[HttpClientAlertViewHelper sharedAlterHelper]showTint:CouldNotConnectServerTint duration:1.5f];
    }
    else if ([errorString isEqualToString:NetworkConnectLostValue]) {
        if (ShowErrorMessage) {
            [[HttpClientAlertViewHelper sharedAlterHelper]showTint:NetworkConnectLostTint duration:1.5f];
        }
    }else if ([errorString isEqualToString:NetWorkBusy]){
        if (ShowErrorMessage) {
            [[HttpClientAlertViewHelper sharedAlterHelper]showTint:@"服务器忙" duration:1.5f];
        }
    }else {
        NSData *responseData = operation.response;
        if (responseData) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            // 得到失败的提示
            NSString *errInfo = [[[responseDic objectForKey:@"detail"]objectForKey:@"non_field_errors"]firstObject] ? :@"";
            
            NSDictionary *userInfor = error.userInfo;
            NSString *domain = error.domain;
            NSInteger code = error.code;
            NSMutableDictionary *newErrorInfor = [NSMutableDictionary dictionaryWithDictionary:userInfor];
            [newErrorInfor setObject:errInfo forKey:@"response"];
            NSError *newError = [NSError errorWithDomain:domain code:code userInfo:newErrorInfor];
            
            NSString *detailStr = [[NSString alloc]initWithData:operation.response encoding:NSUTF8StringEncoding];
//            [[JAlertViewHelper shareAlterHelper]showTint:detailStr duration:1.5];
            
            failure(operation,newError);
            return;
        }
    }
    failure(operation,error);
}

+(BOOL) isNetworkAvailable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+(NSString*)fullUrlWith:(NSString*)address {
    return [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,address];
}

+(void)addTokenWithParameter:(NSMutableDictionary *)parameters manager:(id)manager {
    [((AFHTTPSessionManager *)manager).requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
}

+(void)additionalOperatingWithManager:(AFHTTPSessionManager *)manager parameter:(NSMutableDictionary *)parameters {

}






@end


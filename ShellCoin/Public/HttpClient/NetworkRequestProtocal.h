//
//  NetworkRequestProtocal.h
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/19.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol NetworkRequestProtocal <NSObject>

/*
 * GET 和 POST 请求
 * @param success
 *  对返回的结果进行了json解析，客户端得到的是解析后的json对象
 *
 *  客户端不用管token的传递
 */
+(NSURLSessionDataTask *)GET:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)GETWithFullUrl:(NSString *)URLString
                               parameters:(id)parameters
                                  success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                  failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

+(NSURLSessionDataTask *)POST:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)POSTWithFullUrl:(NSString *)URLString
                                parameters:(id)parameters
                                   success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/*
 *  带token 的请求
 *
 */
+(NSURLSessionDataTask*)POSTWithToken:(NSString*)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask*)GETWithToken:(NSString*)URLString
                            parameters:(id)parameters
                               success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

+(void) addTokenWithParameter:(NSMutableDictionary*) parameters manager:(AFHTTPSessionManager*)manager;

/*
 * 文件的上传和下载
 *
 */

//上传图文
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                     parameters:(id)parameters
                         images:(NSArray*) images
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//上传文件 （使用文件路径上传）
+(void)uploadFileAtPath:(NSString*)filePath toUrl:(NSString *)urlString
               progress:(NSProgress*)progress completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler ;
//上传文件 （上传文件的二进制 NSData）
+(void)uploadFiles:(NSData *)data toUrl:(NSString *)urlString
          progress:(NSProgress*)progress completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler ;

//下载文件
+(void)downloadWithUrl:(NSString *)urlString fileName:(NSString *)fileName downloadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadBlock success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
;

+(void)downloadWithUrl:(NSString *)urlString fileName:(NSString *)fileName needUnzip:(BOOL)needUnzip downloadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadBlock success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;



@end

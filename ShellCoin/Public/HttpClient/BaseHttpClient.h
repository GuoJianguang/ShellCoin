//
//  BaseHttpClient.h
//  TeacherResponder
//
//  Created by tongbu_jinzhongjun on 14/11/6.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SSZipArchive.h"
#import "NetworkRequestProtocal.h"
#import "HttpClientConstant.h"



@interface BaseHttpClient : NSObject <NetworkRequestProtocal>

/*
 * GET 和 POST 请求
 * @param URLString
 *  请求的路径。默认是相对于根目录的路径。
 * @param parameters
 *  请求需要传递的参数
 * @param success
 *  jsonObject 是解析后的对象，客户端直接使用。
 *  Json 解析失败时，会停在断言处
 * @param failure
 *  请求失败的信息
 */

/*
 
 GET 请求
 
 */


+(NSURLSessionDataTask *)GET:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/*
 * @param urlstring 完整的请求路径
 */
+(NSURLSessionDataTask *)GETWithFullUrl:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///*
// * @param headerPara 在请求头里面传的参数
// * @param bodyPara 在请求body里面传的参数
// */
+(NSURLSessionDataTask *)GET:(NSString*)URLString
                               header:(id) headerPara
                                 body:(id) bodyPara
                              success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                              failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)GETWithFullUrl:(NSString*) URLString
                                   header:(id) headerPara
                                     body:(id) bodyPara
                                  success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                  failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
/*
 
 GET 请求
 
 */


+(NSURLSessionDataTask *)POST:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)POSTWithFullUrl:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///*
// * @param headerPara 在请求头里面传的参数
// * @param bodyPara 在请求body里面传的参数
// */
+(NSURLSessionDataTask *)POST:(NSString*)URLString
                        header:(id) headerPara
                          body:(id) bodyPara
                       success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)POSTWithFullUrl:(NSString*) URLString
                                   header:(id) headerPara
                                     body:(id) bodyPara
                                  success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                  failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///*
// *  带token 的请求.默认 不做任何实现
// *  根据实际情况进行实现。
// *  token的处理方式请实现 HttpClient 中的 +(void)addTokenWithParameter: manager: 方法
// *
// */
+(NSURLSessionDataTask*)POSTWithToken:(NSString*)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                                failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask*)GETWithToken:(NSString*)URLString
                            parameters:(id)parameters
                               success:(void (^)(NSURLSessionDataTask *operation, id jsonObject))success
                               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///*
// * 传递 token 的具体实现。如果需要传递token 请实现子类的该方法
// * 可以通过 parameters 参数进行传递，也可以通过manager 在 HttpHeader中添加
// */
//+(void) addTokenWithParameter:(NSMutableDictionary*) parameters manager:(AFHTTPSessionManager*)manager;
//
///*
// * 文件的上传和下载
// *
// */
//
////上传图文
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                     parameters:(id)parameters
                         images:(NSArray*) images
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
+(NSURLSessionDataTask *)POSTWithToken:(NSString *)URLString
                     parameters:(id)parameters
                         images:(NSArray*) images
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//
////上传文件 （使用文件路径上传）
+(void)uploadFileAtPath:(NSString*)filePath toUrl:(NSString *)urlString
               progress:(NSProgress*)progress completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler ;
////上传文件 （上传文件的二进制 NSData）
+(void)uploadFiles:(NSData *)data toUrl:(NSString *)urlString
          progress:(NSProgress*)progress completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler ;
//
////下载文件
+(void)downloadWithUrl:(NSString *)urlString fileName:(NSString *)fileName downloadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadBlock success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//// 下载文件
+(void)downloadWithUrl:(NSString *)urlString fileName:(NSString *)fileName needUnzip:(BOOL)needUnzip downloadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadBlock success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//
//// 成功返回的处理
+(void) handleWithOperation:(NSURLSessionDataTask *)operation responseObject:(id) responseObject success:(void (^)(NSURLSessionDataTask *, id))success;
//
//// 失败返回的处理
+(void) failureHandleWithOperation:(NSURLSessionDataTask *)operation error:(NSError*)error callBack:(void (^)(NSURLSessionDataTask *, NSError *))failure ;
//
//
//// 拼接完整的url 默认使用 base_ure##address
+(NSString*)fullUrlWith:(NSString*)address ;
///* 默认的manager，
// 请求和返回的编码方式使用 RequestSerializerEncoding 和ResponseSerializerEncoding 
// 默认编码方式使用UTF8Encoding，需要修改请在 HttpClientConstant.h 中进行修改
// */
+(AFHTTPSessionManager *) defaultManager;
//
///* 
// * 对请求参数或者manager的其他操作
// * 例如：对参数加密
// * 此方法默认不做任何操作，如需实现，请在子类中实现
// * 直接对参数进行操作
// */
// 
+(void) additionalOperatingWithManager:(AFHTTPSessionManager *) manager parameter:(NSMutableDictionary*) parameters;
///*
// * 检测当前 网络环境是否可用
// * 有网返回 YES
// * 无网返回 NO
// */
+(BOOL) isNetworkAvailable ;

@end






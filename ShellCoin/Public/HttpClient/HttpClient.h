//
//  HttpClient.h
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import "BaseHttpClient.h"

#define DateFormatterString @"yyyyMMddHHmmss"
#define APP_KEY @"12345670"
#define APP_SECRET @"82db84b1a65b4d5dec34d3801bcdb1eb"

@interface HttpClient : BaseHttpClient

@end


// 这个类别是用来进行MD5加密的
@interface NSString(MD5)

-(NSString*)md5_32;

@end
//
//  HttpClientConstant.h
//  Knowledge
//
//  Created by test on 15/3/2.
//  Copyright (c) 2015年 tongbu_jinzhongjun. All rights reserved.
//

#ifndef Knowledge_HttpClientConstant_h
#define Knowledge_HttpClientConstant_h


#define Timeout(error) ([[error.userInfo objectForKey:TimeoutErrorKey]isEqualToString:TimeoutErrorValue] ? YES : NO)
#define NetworkConnectLost(error)  ([[error.userInfo objectForKey:TimeoutErrorKey]isEqualToString:NetworkConnectLostValue] ? YES : NO)
#define CouldNotConnectServerTest(error)  ([[error.userInfo objectForKey:TimeoutErrorKey]isEqualToString:CouldNotConnectServerValue] ? YES : NO)

#define ErrorInfor(error) ([error.userInfo objectForKey:@"response"])


#define JsonFormateError @"Json格式错误"
#define NetworkConnectFailure @"网络连接失败..."

#define TimeoutErrorKey @"NSLocalizedDescription"
#define TimeoutErrorValue @"The request timed out."
#define TimeoutErrorTintString @"网络连接超时"
#define NetworkConnectLostValue @"The network connection was lost."
#define NetworkConnectLostTint @"失去网络连接..."
#define NetWorkBusy @"Request failed: internal server error (500)"

#define CouldNotConnectServerValue @"Could not connect to the server."
#define CouldNotConnectServerTint  @"与服务器失去连接"


// 请求和返回使用的编码方式
#define RequestSerializerEncoding UTF8Encoding
#define ResponseSerializerEncoding UTF8Encoding

// UTF8编码 
#define UTF8Encoding NSUTF8StringEncoding
// GBK 编码
#define GBKEncoding CFStringConvertEncodingToNSStringEncoding(0x0632)

//#define formal_html_base @"https://test.p.tiantianxcn.com/ttx-api/"
#define formal_html_base @"https://api.tiantianxcn.com/ttx-api/"
//#define formal_base @"https://test.p.tiantianxcn.com/ttx-api/3.0.0/"
#define formal_base @"https://api.tiantianxcn.com/ttx-api/3.0.0/"
////正式
#define HttpClient_BaseUrl formal_base

#define HttpClient_MusicOrVideo_BASE_URL linux_musicorvideo_base


// 是否使用 AlertView 展示错误信息
#define ShowErrorMessage 1


// 请求超时设置
#define TimeoutInterval 30


#endif

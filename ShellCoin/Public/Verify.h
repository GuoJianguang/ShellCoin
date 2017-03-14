//
//  Verify.h
//  LoginAndRegister
//
//  Created by inphase on 15/7/17.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VERIFYERRORDOMIAN @"com.jzj.error"

#define PHONENUMBERBLANCKERROR 1000
#define PHONENUMBERLENGTHERROR 1001
#define PHONENUMBERERROR 1002


#define IDNUMBERLENGTHERROR 2000
#define IDNUMBERFORMATERROR 2001


#define BLANCKERROR 3000

typedef void(^VerificationResult)(BOOL success,NSError *error);

@interface Verify : NSObject


// 验证电话号码
-(void) verifyPhoneNumber:(NSString*) phoneNumber callBack:(VerificationResult) callBack;
-(BOOL) verifyPhoneNumber:(NSString*) phoneNumber;

// 验证身份证号码
-(void) verifyIDNumber:(NSString*) idNumber callBack:(VerificationResult) callBack;
-(BOOL)  verifyIDNumber:(NSString*) idNumber;
// 验证注册输入信息
-(void) verifyRegisterInformation:(NSDictionary*) information callBack:(VerificationResult) callBack;
// 验证登录输入信息
-(void) verifyLoginInformation:(NSDictionary*) information callBack:(VerificationResult) callBack;

// 校验是否是空 空 返回 YES  非空 NO
-(BOOL) verifyBlank:(NSString*) string;
-(BOOL) isBlank:(NSString*) string;





@end

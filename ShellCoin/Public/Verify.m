//
//  Verify.m
//  LoginAndRegister
//
//  Created by inphase on 15/7/17.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "Verify.h"




@implementation Verify


-(BOOL)verifyPhoneNumber:(NSString *)phoneNumber {
    // 首先不能为空
    if (!phoneNumber) {
        return NO;
    }
    // 不为空
    else {
        // 检测号码长度
        NSInteger length = phoneNumber.length;
        if (length < 11) {
            return NO;
        }
        // 然后检测是不是正确的电话号码
        else {
            
            NSString *regular = @"0?1[3,4,5,7,8]\\d{9}";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@",regular];
            if (![predicate evaluateWithObject:phoneNumber]) {
                return NO;
            }
        }
    }
    return YES;
}

-(void)verifyPhoneNumber:(NSString *)phoneNumber callBack:(VerificationResult)callBack {

    // 首先不能为空
    if (!phoneNumber) {
        NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:PHONENUMBERBLANCKERROR userInfo:@{NSLocalizedDescriptionKey:@"电话号码不能为空"}];
        callBack(NO,error);
    }
    // 不为空
    else {
        // 检测号码长度
        NSInteger length = phoneNumber.length;
        if (length < 11) {
            NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:PHONENUMBERLENGTHERROR userInfo:@{NSLocalizedDescriptionKey:@"电话号码长度不正确"}];
            callBack(NO,error);
        }
        // 然后检测是不是正确的电话号码
        else {
        
            NSString *regular = @"0?1[3,4,5,7,8]\\d{9}";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@",regular];
            if ([predicate evaluateWithObject:phoneNumber]) {
                callBack(YES,nil);
            }else {
            
                NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:PHONENUMBERERROR userInfo:@{NSLocalizedDescriptionKey:@"电话号码格式不对"}];
                callBack(NO,error);
            }
        }
    }
}

-(BOOL)verifyIDNumber:(NSString *)idNumber {

    NSString *value = [idNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 首先验证身份证号码长度
    if ([value length] != 18) {
        
        return NO;
    }
    // 长度正确
    else {
        
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
        
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        // 正则表达式不匹配
        if (![regexTest evaluateWithObject:value]) {
            return NO;
        }
        // 匹配正则表达式
        else {
            int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
            + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
            + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
            + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
            + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
            + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
            + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
            + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
            + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
            NSInteger remainder = summary % 11;
            NSString *checkBit = @"";
            NSString *checkString = @"10X98765432";
            checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];
            // 判断校验位
            BOOL checkBitRight = [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
            // 校验位正确
            if (checkBitRight) {
                return YES;
            }else {
                
                return NO;
            }
        }
    }
}


-(void)verifyIDNumber:(NSString *)idNumber callBack:(VerificationResult)callBack {

   NSString *value = [idNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 首先验证身份证号码长度
    if ([value length] != 18) {
        
        NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:IDNUMBERLENGTHERROR userInfo:@{NSLocalizedDescriptionKey:@"身份证长度不对"}];
        callBack(NO,error);
    }
    // 长度正确
    else {
    
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
        
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        // 正则表达式不匹配
        if (![regexTest evaluateWithObject:value]) {
            NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:IDNUMBERFORMATERROR userInfo:@{NSLocalizedDescriptionKey:@"身份证格式不对"}];
            callBack(NO,error);
        }
        // 匹配正则表达式
        else {
            int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
            + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
            + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
            + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
            + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
            + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
            + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
            + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
            + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
            NSInteger remainder = summary % 11;
            NSString *checkBit = @"";
            NSString *checkString = @"10X98765432";
            checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];
            // 判断校验位
            BOOL checkBitRight = [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
            // 校验位正确
            if (checkBitRight) {
                callBack(YES,nil);
            }else {
            
                NSError *error = [NSError errorWithDomain:VERIFYERRORDOMIAN code:IDNUMBERFORMATERROR userInfo:@{NSLocalizedDescriptionKey:@"身份证格式不对"}];
                callBack(NO,error);
            }
        }
    }
}


-(void)verifyLoginInformation:(NSDictionary *)information callBack:(VerificationResult)callBack {
    
    
    

}

-(void)verifyRegisterInformation:(NSDictionary *)information callBack:(VerificationResult)callBack {

    
    //因为是字典的形式传递过来的，所以不是nil
    NSString *password = [information objectForKey:@"password"];
    NSString *nickName = [information objectForKey:@"nickName"];
    NSString *verify_code = [information objectForKey:@"verify_code"];
    
    if ([verify_code isEqualToString:@""]) {
        
        NSError *error = [[NSError alloc] initWithDomain:VERIFYERRORDOMIAN code:BLANCKERROR userInfo:@{NSLocalizedDescriptionKey:@"验证码不能为空"}];
        callBack(NO,error);
    }else if ([password isEqualToString:@""] ) {
    
        NSError *error = [[NSError alloc] initWithDomain:VERIFYERRORDOMIAN code:BLANCKERROR userInfo:@{NSLocalizedDescriptionKey:@"密码不能为空"}];
        callBack(NO,error);
    }else if ( [nickName isEqualToString:@""]) {
    
        NSError *error = [[NSError alloc] initWithDomain:VERIFYERRORDOMIAN code:BLANCKERROR userInfo:@{NSLocalizedDescriptionKey:@"昵称不能为空"}];
        callBack(NO,error);
    }else {
    
        callBack(YES,nil);
    }
    
    
}

-(BOOL)verifyBlank:(NSString *)string {

    if (!string || [string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(BOOL)isBlank:(NSString *)string {

    return [self verifyBlank:string];
}

@end































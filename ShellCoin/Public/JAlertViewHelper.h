//
//  JAlertViewHelper.h
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JAlertViewHelper : NSObject

+(JAlertViewHelper*) shareAlterHelper;
-(void) showTint:(NSString*)message duration:(NSTimeInterval) timeInterval;
@end
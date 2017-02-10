//
//  JAlertViewHelper.m
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import "JAlertViewHelper.h"
#import <UIKit/UIKit.h>

@implementation JAlertViewHelper

+(JAlertViewHelper *)shareAlterHelper{
    static JAlertViewHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JAlertViewHelper alloc] init];
    });
    
    return instance;
}

-(void) showTint:(NSString*)message duration:(NSTimeInterval) timeInterval {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alter show];
        
        [self performSelector:@selector(hideAlterView:) withObject:alter afterDelay:timeInterval];
    });
}

-(void) hideAlterView:(UIAlertView*)alter {
    [alter dismissWithClickedButtonIndex:0 animated:YES];
}

@end

//
//  JAlertViewHelper.m
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import "HttpClientAlertViewHelper.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation HttpClientAlertViewHelper{
    
    UIAlertController *alertController;
    UIAlertView *alertView;
    NSLock *lock;
}

+(HttpClientAlertViewHelper *)sharedAlterHelper{
    static HttpClientAlertViewHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HttpClientAlertViewHelper alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        lock = [[NSLock alloc] init];
        alertView = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    }
    return self;
}

-(void) showTint:(NSString*)message duration:(NSTimeInterval) timeInterval {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//            
//            alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
//            UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
//            while (controller.presentedViewController) {
//                controller = controller.presentedViewController;
//            }
//            if (!controller) {
//                controller = [UIApplication sharedApplication].keyWindow.rootViewController;
//            }
//            
//            [NSObject cancelPreviousPerformRequestsWithTarget:controller selector:@selector(presentViewController:animated:completion:) object:alertController];
//            [controller presentViewController:alertController animated:YES completion:nil];
//
//            [self performSelector:@selector(hideAlterView:) withObject:alertController afterDelay:timeInterval];
//        }else {
        
            alertView.message = message;
            [NSObject cancelPreviousPerformRequestsWithTarget:alertView selector:@selector(show) object:nil];
            [alertView show];
            [self performSelector:@selector(hideAlterView:) withObject:alertView afterDelay:timeInterval];
//        }
    });
}

-(void) hideAlterView:(id)alter {
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        [alter dismissViewControllerAnimated:YES completion:nil];
//    }else {
        [alter dismissWithClickedButtonIndex:0 animated:YES];
//    }
}

@end

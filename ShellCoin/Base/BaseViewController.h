//
//  BaseViewController.h
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationBar.h"


@interface BaseViewController : UIViewController

@property (nonatomic,strong) BaseNavigationBar *naviBar;

+(id) controller;
+(id) controllerWithIdentifier:(NSString*) identifier;

@end

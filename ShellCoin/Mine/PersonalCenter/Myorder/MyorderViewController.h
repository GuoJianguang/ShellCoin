//
//  MyorderViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "SortButtonSwitchView.h"

@interface MyorderViewController : BaseViewController
@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;


@end

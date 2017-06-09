//
//  MyRecommendDetailListViewController.h
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "BaseViewController.h"
#import "SortButtonSwitchView.h"

@interface MyRecommendDetailListViewController : BaseViewController

@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@end

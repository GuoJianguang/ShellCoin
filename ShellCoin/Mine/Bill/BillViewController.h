//
//  BillViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "SortButtonSwitchView.h"

@interface BillViewController : BaseViewController
@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;


@end

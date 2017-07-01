//
//  MyorderViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "SortButtonSwitchView.h"


typedef NS_ENUM(NSInteger,Myorder_type){
    Myorder_type_waitPay = 0,//待付款
    Myorder_type_waitSendGoods = 1,//待发货
    Myorder_type_waitReceiveGoods = 2,//待收货
    Myorder_type_compelte= 3,//已完成
};



@interface MyorderViewController : BaseViewController
@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (nonatomic,assign)Myorder_type orderType;

@property (nonatomic, assign)BOOL isFormMall;

@end

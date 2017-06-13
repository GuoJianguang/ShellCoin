//
//  MyorderView.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,Myorder_type){
    Myorder_type_waitPay = 1,//待付款
    Myorder_type_waitSendGoods = 2,//待发货
    Myorder_type_waitReceiveGoods = 3,//待收货
    Myorder_type_compelte= 4,//已完成
};



@interface MyorderView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)Myorder_type orderType;

- (void)reload;
@end

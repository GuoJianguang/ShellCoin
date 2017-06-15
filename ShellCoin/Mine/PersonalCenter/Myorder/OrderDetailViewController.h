//
//  OrderDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "MyorderViewController.h"

@interface OrderDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign)Myorder_type orderType;

@end

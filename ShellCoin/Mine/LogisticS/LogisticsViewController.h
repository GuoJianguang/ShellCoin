//
//  LogisticsViewController.h
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
@class BuyRecodeModel;

@interface LogisticsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)BuyRecodeModel *dataModel;


@end

//
//  MyorderView.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyorderViewController.h"


@interface MyorderView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)Myorder_type orderType;

- (void)reload;
@end

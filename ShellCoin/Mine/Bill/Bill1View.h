//
//  Bill1View.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bill1View : UIView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)reload;

@end

//
//  Bill3View.h
//  ShellCoin
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bill3View : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)reload;

@end

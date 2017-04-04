//
//  MessageDetailViewController.h
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageTableViewCell.h"

@interface MessageDetailViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)MessafeModel *dataModel;

@end

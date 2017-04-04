//
//  MessageDetailTableViewCell.h
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableViewCell.h"

@interface MessageDetailTableViewCell : BaseTableViewCell


@property (nonatomic, strong)MessafeModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *titel_label;
@property (weak, nonatomic) IBOutlet UILabel *detail_label;

@property (weak, nonatomic) IBOutlet UILabel *time_label;

@end

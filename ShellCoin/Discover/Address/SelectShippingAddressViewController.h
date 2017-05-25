//
//  MallSelectShippingAddressViewController.h
//  tiantianxin
//
//  Created by ttx on 16/4/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectShippingAddressViewController : BaseViewController

- (void)addressRequest;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

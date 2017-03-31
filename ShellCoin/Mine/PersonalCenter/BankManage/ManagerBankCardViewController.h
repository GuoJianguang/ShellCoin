//
//  ManagerBankCardViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface ManagerBankCardViewController : BaseViewController
@property (nonatomic, assign)NSInteger currentPage;
- (void)getmyBankCardRequest;
@end

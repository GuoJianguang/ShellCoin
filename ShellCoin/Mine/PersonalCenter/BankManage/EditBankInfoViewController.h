//
//  EditBankInfoViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@class BankCardInfoModel;
@interface EditBankInfoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)BankCardInfoModel *bankModel;
@property (nonatomic, assign)BOOL isYetBingdingCard;

@end

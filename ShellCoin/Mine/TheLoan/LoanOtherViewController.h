//
//  LoanOtherViewController.h
//  ShellCoin
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,Loan_type){
    Loan_type_fail = 1,//失败
    Loan_type_audit = 2,//等待审核
};

@interface LoanOtherViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, assign)Loan_type loanType;
@end

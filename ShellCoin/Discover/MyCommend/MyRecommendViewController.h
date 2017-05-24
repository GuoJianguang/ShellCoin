//
//  MyRecommendViewController.h
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MyRecommendViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *activatedAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

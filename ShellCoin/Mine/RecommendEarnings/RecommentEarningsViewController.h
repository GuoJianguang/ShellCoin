//
//  RecommentEarningsViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface RecommentEarningsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *qrcodeBtn;
- (IBAction)qrcodeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UITableView *talbeView;

@property (weak, nonatomic) IBOutlet UIButton *withdrawalBtn;
- (IBAction)withdrawalBtn:(UIButton *)sender;

@end

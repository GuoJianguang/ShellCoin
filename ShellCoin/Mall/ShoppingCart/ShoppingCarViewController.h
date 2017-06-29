//
//  ShoppingCarViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface ShoppingCarViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (IBAction)selectBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;

@property (nonatomic, strong)NSMutableArray *dataSouceArray;


- (void)calculateTheTotalAmount;


@end

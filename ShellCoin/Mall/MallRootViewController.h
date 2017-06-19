//
//  MallRootViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MallRootViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UITextField *searchTF;


@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyCarBtn;
- (IBAction)buyCarBtn:(UIButton *)sender;

@end

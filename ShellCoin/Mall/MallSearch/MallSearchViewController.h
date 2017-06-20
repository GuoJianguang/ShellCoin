//
//  MallSearchViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallSearchViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
- (IBAction)deleBtn:(UIButton *)sender;

@end

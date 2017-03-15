//
//  YesTodayEarningsAlerView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YesTodayEarningsAlerView : UIView

@property (weak, nonatomic) IBOutlet UIView *blackBackgoundView;

@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UILabel *yesdayELabel;
@property (weak, nonatomic) IBOutlet UILabel *showyestodayELabel;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
- (IBAction)deletBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *jichuelabel;

@property (weak, nonatomic) IBOutlet UILabel *huiyuanLablel;

@property (weak, nonatomic) IBOutlet UILabel *showJichuLabel;
@property (weak, nonatomic) IBOutlet UILabel *showDengjiLabel;

@end

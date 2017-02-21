//
//  EditbankInfoTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditbankInfoTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *upView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upViewHeight;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UIView *view5;

@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UIView *view7;

@property (weak, nonatomic) IBOutlet UIView *view8;

@property (weak, nonatomic) IBOutlet UIButton *selcetZHNumBtn;

- (IBAction)selcetZHNumBtn:(UIButton *)sender;


@end

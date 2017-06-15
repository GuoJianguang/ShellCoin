//
//  WaitAfterForSalesViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface WaitAfterForSalesViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *alerResultImageView;



@property (weak, nonatomic) IBOutlet UIImageView *titleimageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;


@end

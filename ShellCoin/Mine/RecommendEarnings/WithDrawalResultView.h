//
//  WithDrawalResultView.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithDrawalResultView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *alerResultImageView;

@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (weak, nonatomic) IBOutlet UIImageView *titleimageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;


@end

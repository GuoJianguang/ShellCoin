//
//  SetTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UILabel *cleanLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutUsLabel;

@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

- (IBAction)exitBtn:(UIButton *)sender;

- (IBAction)phoneBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *passwordBtn;
- (IBAction)passwordBtn:(id)sender;

- (IBAction)cleanBtn:(id)sender;
- (IBAction)aboutUsBtn:(id)sender;

@end

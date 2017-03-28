//
//  EnterInputMoneyView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"

@interface EnterInputMoneyView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UIButton *canelBtn;
- (IBAction)canelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *sureView;

@property (nonatomic, strong)MerchantModel *dataModel;
@end

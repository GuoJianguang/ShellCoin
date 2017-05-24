//
//  SelectBanCardView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;

@interface SelectGoodsNumberView : UIView

@property (weak, nonatomic) IBOutlet UIView *blackBackgoundView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;


@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)addBtn:(UIButton *)sender;
- (IBAction)minusBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *minusBtn;


@end

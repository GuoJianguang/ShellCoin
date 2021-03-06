//
//  EditbankInfoTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;

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


@property (weak, nonatomic) IBOutlet UITextField *bankCardNu;
@property (weak, nonatomic) IBOutlet UITextField *bankLabel;
@property (weak, nonatomic) IBOutlet UITextField *provincesTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangNumdTF;
@property (weak, nonatomic) IBOutlet UITextField *wangdianTF;
@property (weak, nonatomic) IBOutlet UITextField *inputKaihuhangTF;


@property (weak, nonatomic) IBOutlet UIButton *selcetZHNumBtn;

- (IBAction)selcetZHNumBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top8Height;

- (void)sureEdit;

@property (nonatomic, strong)BankCardInfoModel *bankModel;

@property (nonatomic, assign)BOOL isYetBingdingCard;

@property (nonatomic, assign)BOOL isFromRoomPage;

#pragma mark - 提示label
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;


@end

//
//  ManageBankView.h
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;

@interface ManageBankView : UIView
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)editBtn:(id)sender;

@property (weak, nonatomic) IBOutlet ShellCoinPageControlView *pageContrlVIew;

@property (weak, nonatomic) IBOutlet UIView *upView;

@property (nonatomic, strong)BankCardInfoModel *bankModel;

@end

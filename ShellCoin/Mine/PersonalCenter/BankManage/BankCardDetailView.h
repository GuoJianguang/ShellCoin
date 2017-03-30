//
//  BankCardDetailView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/30.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;
@interface BankCardDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankMarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankMarkImageView;
@property (nonatomic, strong)BankCardInfoModel *dataModel;

@end

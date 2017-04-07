//
//  BankInfoCollectionViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/4/5.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;

@interface BankInfoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankMarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankMarkImageView;
@property (nonatomic, strong)BankCardInfoModel *dataModel;
@property (weak, nonatomic) IBOutlet UIImageView *backgoundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWitdth1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWitdth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottmHeight;

@property (nonatomic, assign)NSInteger count;
@end

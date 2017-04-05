//
//  BankInfoCollectionViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/4/5.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BankInfoCollectionViewCell.h"
#import "BankCardInfoModel.h"


@implementation BankInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cardNumLabel.adjustsFontSizeToFitWidth =self.nameLabel.adjustsFontSizeToFitWidth= self.bankMarkLabel.adjustsFontSizeToFitWidth= self.bankNameLabel.adjustsFontSizeToFitWidth= YES;
}

- (void)setDataModel:(BankCardInfoModel *)dataModel
{
    _dataModel = dataModel;
    self.nameLabel.text = _dataModel.realName;
    self.bankNameLabel.text  = _dataModel.bankName;
    NSString *str = @"";
    if (_dataModel.bankAccount.length > 7) {
        for (int i =0; i < _dataModel.bankAccount.length; i ++) {
            if (i>3&&i<_dataModel.bankAccount.length-3) {
                str = [NSString stringWithFormat:@"%@%@",str,@"*"];
            }else{
                NSString *temp = [_dataModel.bankAccount substringWithRange:NSMakeRange(i, 1)];
                str = [NSString stringWithFormat:@"%@%@",str,temp];
                
            }
        }
    }
    self.cardNumLabel.text = [self normalNumToBankNum1:str];
}


-(NSString *)normalNumToBankNum1:(NSString *)tmpStr
{
    if (tmpStr.length < 7) {
        return tmpStr;
    }
    NSInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}


- (void)setCount:(NSInteger)count
{
    _count = count;
    switch ((_count+1)%5) {
        case 1:
            self.backgoundImageView.image = [UIImage imageNamed:@"pic_bank_blue"];
            
            break;
        case 2:
            self.backgoundImageView.image = [UIImage imageNamed:@"pic_bank_green"];
            
            break;
        case 3:
            self.backgoundImageView.image = [UIImage imageNamed:@"pic_bank_orange"];
            
            break;
        case 4:
            self.backgoundImageView.image = [UIImage imageNamed:@"pic_bank_purple"];
            
            break;
        case 5:
            self.backgoundImageView.image = [UIImage imageNamed:@"pic_bank_red"];
            
            break;
            
        default:
            break;
    }
    
}

-(void)setModel:(id)model{
    
    _dataModel = model;
    self.nameLabel.text = _dataModel.realName;
    self.bankNameLabel.text  = _dataModel.bankName;
    NSString *str = @"";
    if (_dataModel.bankAccount.length > 7) {
        for (int i =0; i < _dataModel.bankAccount.length; i ++) {
            if (i>3&&i<_dataModel.bankAccount.length-3) {
                str = [NSString stringWithFormat:@"%@%@",str,@"*"];
            }else{
                NSString *temp = [_dataModel.bankAccount substringWithRange:NSMakeRange(i, 1)];
                str = [NSString stringWithFormat:@"%@%@",str,temp];
                
            }
        }
    }
    self.cardNumLabel.text = [self normalNumToBankNum1:str];
}


@end

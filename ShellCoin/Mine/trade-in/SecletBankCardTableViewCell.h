//
//  SecletBankCardTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankInfoModel : BaseModel
@property (nonatomic, copy)NSString *logicon;
@property (nonatomic, copy)NSString *bankName;
@property (nonatomic, copy)NSString *bankCardNum;
@property (nonatomic, assign)BOOL isSeclet;
@end


@interface SecletBankCardTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *banklogImage;

@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;

@property (weak, nonatomic) IBOutlet UIImageView *selcetmarkIamge;

@property (nonatomic, strong)BankInfoModel *dataModel;



@end

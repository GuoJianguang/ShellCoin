//
//  MerchantTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/27.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"

@interface MerchantTableViewCell : BaseTableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *bussessImage;

@property (weak, nonatomic) IBOutlet UILabel *kimter_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;

@property (weak, nonatomic) IBOutlet UILabel *detail_label;


@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UIImageView *kmiterImage;

@property (weak, nonatomic) IBOutlet UIImageView *recommendImage;


@property (nonatomic, strong)MerchantModel *dataModel;

@end

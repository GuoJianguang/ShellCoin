//
//  HomeMerchantTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMerchantTableViewCell : BaseTableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headIamgeView;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *detail_label;

@end

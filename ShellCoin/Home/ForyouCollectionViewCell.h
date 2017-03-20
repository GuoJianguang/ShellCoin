//
//  ForyouCollectionViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForyouCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

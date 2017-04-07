//
//  RecommentSpecilCollectionViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommentSpecilCollectionViewCell.h"

@implementation RecommentSpecilCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPic:(NSString *)pic
{
    _pic = pic;
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:_pic] placeholderImage:LoadingErrorDefaultImageCircular];
}



@end

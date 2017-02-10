//
//  BaseCollectionViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

//返回重用标示
+ (NSString *)indentify
{
    return NSStringFromClass([self class]);
}
//创建cell
+ (UINib *)newCell
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return nib;
}


@end

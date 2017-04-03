//
//  AreaTableViewCell.m
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "AreaTableViewCell.h"

@implementation AreaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//返回重用标示
+ (NSString *)indentify
{
    return @"AreaTableViewCell";
}
//创建cell
+ (id)newCell
{
    NSArray *array  = [[NSBundle mainBundle]loadNibNamed:@"AreaTableViewCell" owner:nil options:nil];
    return array[0];
}
@end

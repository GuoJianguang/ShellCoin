//
//  BaseTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/8.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;

@end

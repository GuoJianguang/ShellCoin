//
//  AreaTableViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *area_label;

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (id)newCell;

@end

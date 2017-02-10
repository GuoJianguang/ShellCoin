//
//  BaseCollectionViewCell.h
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

//返回重用标示
+ (NSString *)indentify;
//创建xib中的cell
+ (UINib *)newCell;

@end

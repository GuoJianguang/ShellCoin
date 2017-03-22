//
//  RecommentSpecilCollectionViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentModel.h"

@interface RecommentSpecilCollectionViewCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (nonatomic, strong)RecommentModel *dataModel;


@end

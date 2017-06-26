//
//  MallSortView.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MallSortViewdelegate <NSObject>

- (void)selectSort:(NSString *)sortId withName:(NSString *)sortName;
@end

@interface MallSortView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, copy)NSString *yetSeletId;

@property (nonatomic, assign)id<MallSortViewdelegate> delegate;

@end

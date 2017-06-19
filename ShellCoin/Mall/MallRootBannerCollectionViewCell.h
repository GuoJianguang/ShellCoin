//
//  MallRootBannerCollectionViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallRootBannerCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (weak, nonatomic) IBOutlet ShellCoinPageControlView *pageView;
@property (weak, nonatomic) IBOutlet UIView *insturdyView;

@property (nonatomic, strong)NSMutableArray *bannerArray;
@property (weak, nonatomic) IBOutlet UIButton *recommBtn;

@property (weak, nonatomic) IBOutlet UIView *recommendView;

@end

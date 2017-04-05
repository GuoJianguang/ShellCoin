//
//  UICollectionView+NoDataSouce.h
//  Tourguide
//
//  Created by inphase on 15/4/28.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NothingView.h"

@interface UIScrollView (NoDataSouce)


- (void)noDataSouce;
- (void)showNoDataSouce;
- (void)hiddenNoDataSouce;
- (void)showNoDataSouceNoNetworkConnection;

- (void)judgeIsHaveDataSouce:(NSMutableArray *)dataSouceArray;
- (void)judgeIsHaveDataSouce:(NSMutableArray *)dataSouceArray andBannerArray:(NSMutableArray *)bannerArray;


- (void)addNoDatasouceWithCallback:(void (^)())callback andAlertSting:(NSString *)alerString andErrorImage:(NSString *)imageName andRefreshBtnHiden:(BOOL)isHidden;

- (void)changeAlerSring:(NSString *)alerString andErrorImage:(NSString *)imageName;
- (void)showRereshBtnwithALerString:(NSString *)alerString;

@end

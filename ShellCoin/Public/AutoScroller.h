//
//  autoScroll.h
//  Tourguide
//
//  Created by inphase on 15/5/4.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SwipeView,HomeImageSwitchIndicatorView;

@interface AutoScroller : NSObject

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)SwipeView *swipeView;

@property (nonatomic, strong)HomeImageSwitchIndicatorView *lineView;
@property (nonatomic, strong)UIPageControl *page_View;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)NSInteger temp;

- (void)autoSwipeView:(SwipeView *)swipeView WithLineView:(HomeImageSwitchIndicatorView*)lineView WithDataSouceArray:(NSMutableArray *)dataSouceArray;

- (void)autoSwipeView:(SwipeView *)swipeView WithPageView:(UIPageControl *)pageView WithDataSouceArray:(NSMutableArray *)dataSouceArray;


+(instancetype) shareAutoScroller;


- (void)stop;

@end

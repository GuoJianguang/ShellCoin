//
//  autoScroll.m
//  Tourguide
//
//  Created by inphase on 15/5/4.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "AutoScroller.h"
#import "SwipeView.h"
//#import "HomeImageSwitchIndicatorView.h"

@implementation AutoScroller


static AutoScroller *_instance = nil;

static NSTimeInterval _time = 3;


+(instancetype) shareAutoScroller
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;

    return _instance ;
}

- (void)autoSwipeView:(SwipeView *)swipeView WithLineView:(HomeImageSwitchIndicatorView *)lineView WithDataSouceArray:(NSMutableArray *)dataSouceArray;
{
    [self.timer invalidate];
    self.swipeView = swipeView;
    self.lineView = lineView;
    self.dataSouceArray = dataSouceArray;
    _temp = 0;
    [self.swipeView scrollToItemAtIndex:_temp duration:0.0];
    
//    self.lineView.currentIndicatorIndex = _temp;
    self.swipeView.autoscroll = - 0;
    self.swipeView.wrapEnabled = NO;
    if (dataSouceArray.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    }
}

- (void)autoSwipeView:(SwipeView *)swipeView WithPageView:(UIPageControl *)pageView WithDataSouceArray:(NSMutableArray *)dataSouceArray
{
    [self.timer invalidate];
    self.swipeView = swipeView;
    self.page_View = pageView;
    self.dataSouceArray = dataSouceArray;
    _temp = 0;
    [self.swipeView scrollToItemAtIndex:_temp duration:0.0];
    
    self.page_View.currentPage = _temp;
    self.swipeView.autoscroll = - 0;
    self.swipeView.wrapEnabled = NO;
    if (dataSouceArray.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    }
}


//自动轮播
- (void)autoScroll
{
    self.swipeView.wrapEnabled = YES;
    if (_temp >= self.dataSouceArray.count - 1) {
        _temp = 0;
    }else{
        _temp ++;
    }
    
    [self.swipeView scrollToItemAtIndex:_temp duration:0.8];
}

- (void)stop
{
    [self.timer invalidate];
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end

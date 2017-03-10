//
//  SortButtonSwitchView.h
//  Tourguide
//
//  Created by inphase on 15/5/19.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <Availability.h>
#undef weak_delegate
#if __has_feature(objc_arc) && __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif

#import <UIKit/UIKit.h>
@protocol SortButtonSwitchViewDelegate;

@interface SortButtonSwitchView : UIView

//@property (nonatomic, weak_delegate) IBOutlet id<SwipeViewDataSource> dataSource;
@property (nonatomic, weak_delegate) IBOutlet id<SortButtonSwitchViewDelegate> delegate;
//标记当前分类
@property (nonatomic, strong)UIImageView *markImageView;
//分类名称的数组
@property (nonatomic, strong)NSArray *titleArray;

- (void )sortBtn:(UIButton *)sender;
//选中某个选项
- (void)selectItem:(NSInteger )index;

@end


@protocol SortButtonSwitchViewDelegate <NSObject>

- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId;

@end

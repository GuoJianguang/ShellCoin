//
//  HomeTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHomeModel: BaseModel
/**
 * id
 */
@property (nonatomic, copy)NSString  *bannerId;
/**
 * 跳转方式（1：APP商户详情 2：APP产品详情 3：网页）
 */
@property (nonatomic, copy)NSString  *jumpWay;
/**
 * 跳转参数值
 */
@property (nonatomic, copy)NSString  *jumpValue;
/**
 * 图片
 */
@property (nonatomic, copy)NSString  *pic;

/*
 名称
 */
@property (nonatomic, copy)NSString  *name;

//是否有跳转
@property (nonatomic, assign)BOOL isJump;

@end


@interface HomeBannerTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (weak, nonatomic) IBOutlet ShellCoinPageControlView *pageView;

@property (nonatomic, strong)NSMutableArray *bannerArray;




@end

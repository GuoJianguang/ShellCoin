//
//  TypeView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MallSearchSortViewSeleteDelegete <NSObject>

-(void)btn:(UIButton*)button withIndex:(int)tag;

@end
@interface MallSearchSortView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,weak) id<MallSearchSortViewSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename andSortImage:(NSString *)imagename;

@property (nonatomic, assign)BOOL isLineHidde;

@end

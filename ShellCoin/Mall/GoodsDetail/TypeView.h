//
//  TypeView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypeView;
@protocol TypeSeleteDelegete <NSObject>

-(void)btn:(UIButton*)button withIndex:(int)tag withSelf:(TypeView *)viewself;

@end
@interface TypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,weak) id<TypeSeleteDelegete> delegate;

@property (nonatomic, copy)NSString *sepecId;
@property (nonatomic, copy)NSString *typeName;
@property (nonatomic, copy)NSString *specVal;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;
@end

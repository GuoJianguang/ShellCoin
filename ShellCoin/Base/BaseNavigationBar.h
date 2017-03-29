//
//  BaseNavigationBar.h
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BasenavigationDelegate <NSObject>

@optional
- (void)detailBtnClick;
@optional
- (void)backBtnClick;

@end

typedef void(^BackButtonClick)(void);

typedef void(^DetailButtonClick)(void);


@interface BaseNavigationBar : UIView



+(instancetype)navigationBar;


- (IBAction)back_btn:(UIButton *)sender;

//标题
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic)NSString *title;

//右边详情按钮
@property (weak, nonatomic) IBOutlet UIButton *detail_btn;
@property (nonatomic, strong)NSString *detailTitle;
- (IBAction)detail_btn:(UIButton *)sender;
@property (nonatomic,assign) BOOL hiddenDetailBtn;

//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *back_btn;
//返回按钮的文字
@property (weak, nonatomic) IBOutlet UILabel *back_title;
@property (nonatomic, strong)NSString *backTitle;
@property (nonatomic, strong)UIImage *detailImage;
@property (nonatomic, strong)UIImage*backImage;


@property (nonatomic, assign)id<BasenavigationDelegate> delegate;

@property (nonatomic, assign) BackButtonClick back;

@property (nonatomic, assign) DetailButtonClick detail;

//隐藏返回按钮
@property (nonatomic,assign) BOOL hiddenBackBtn;


@property (nonatomic, assign)BOOL hiddenBackBtnImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backtitle_leading;


@property (weak, nonatomic) IBOutlet UIView *lineVIew;

@property (weak, nonatomic) IBOutlet UIImageView *mineBgImageview;

//设置渐变颜色
@property (nonatomic, assign)BOOL showJianbianColor;

@end

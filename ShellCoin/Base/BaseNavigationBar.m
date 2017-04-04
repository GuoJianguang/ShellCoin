//
//  BaseNavigationBar.m
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//
#import "BaseNavigationBar.h"

@implementation BaseNavigationBar


-(void)setHiddenBackBtn:(BOOL)hiddenBackBtn {
    _hiddenBackBtn = hiddenBackBtn;
    self.back_btn.hidden = hiddenBackBtn;
}

- (void)setHiddenDetailBtn:(BOOL)hiddenDetailBtn
{
    _hiddenDetailBtn = hiddenDetailBtn;
    self.detail_btn.hidden = _hiddenDetailBtn;
}

- (void)setDetailTitle:(NSString *)detailTitle
{
    _detailTitle = detailTitle;
    [self.detail_btn setTitle:_detailTitle forState:UIControlStateNormal];
}
//设置详情按钮的图片
- (void)setDetailImage:(UIImage *)detailImage
{
    _detailImage = detailImage;
    [self.detail_btn setBackgroundImage:_detailImage forState:UIControlStateNormal];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.detail_btn.hidden = YES;
    //添加点击事件
    [self sendSubviewToBack:self.mineBgImageview];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back_title:)];
    self.back_title.userInteractionEnabled = YES;
    [self.back_title addGestureRecognizer:ges];
    self.backgroundColor = [UIColor clearColor];
    self.title_label.textColor = [UIColor whiteColor];
    self.back_title.textColor = [UIColor blackColor];
    [self.detail_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

+(instancetype)navigationBar {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"BaseNavigationBar" owner:nil options:nil] firstObject];
}

- (IBAction)back_btn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(backBtnClick)]) {
        [self.delegate backBtnClick];
    }else{
        UIViewController *viewController = self.viewController;
        if (viewController.navigationController) {
            [viewController.navigationController popViewControllerAnimated:YES];
        }else {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
//    if (self.back) {
//        self.back();
//    }else {
//        UIViewController *viewController = self.viewController;
//        
//        if (viewController.navigationController) {
//            [viewController.navigationController popViewControllerAnimated:YES];
//        }else {
//            [viewController dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
}


- (IBAction)detail_btn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detailBtnClick)]) {
        [self.delegate detailBtnClick];
    }
//    if (self.detail) {
//        self.detail();
//    }else {
//        return;
//    }
}
- (void)setShowJianbianColor:(BOOL)showJianbianColor
{
    _showJianbianColor = showJianbianColor;
    if (_showJianbianColor) {
        [self setjianpianColor];
    }
}

//设置渐变色
- (void)setjianpianColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0 , 0,TWitdh , 64);
    
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    UIColor *statColor = [UIColor colorWithRed:244/255. green:91/255. blue:80/255. alpha:1.];
    UIColor *endColor = [UIColor colorWithRed:244/255. green:165/255. blue:80/255. alpha:1.];

    
    gradient.colors = [NSArray arrayWithObjects:
                       (id)statColor.CGColor,
                       (id)endColor.CGColor,
                       nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)back_title:(UITapGestureRecognizer *)ges
{
    if ([self.delegate respondsToSelector:@selector(backBtnClick)]) {
        [self.delegate backBtnClick];
    }
}

//设置标题
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.title_label.text = _title;
}

//设置返回的标题
- (void)setBackTitle:(NSString *)backTitle
{
    _backTitle = backTitle;
    self.back_title.hidden = NO;
    self.back_title.text = _backTitle;
}

- (void)setBackImage:(UIImage *)backImage
{
    _backImage = backImage;
    [self.back_btn setImage:backImage forState:UIControlStateNormal];
}

- (void)setHiddenBackBtnImage:(BOOL)hiddenBackBtnImage
{
    _hiddenBackBtnImage = hiddenBackBtnImage;
    if (_hiddenBackBtnImage) {
        self.backtitle_leading.constant = -30;
    }
}


@end

//
//  SortButtonSwitchView.m
//  Tourguide
//
//  Created by inphase on 15/5/19.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "SortButtonSwitchView.h"


@interface SortButtonSwitchView()

{
    CGFloat markHeight;
    NSInteger mark;
}

@end

@implementation SortButtonSwitchView


- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 11 + i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor]  forState:UIControlStateSelected];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(sortBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    //默认选中第一个
    ((UIButton *)[self viewWithTag:11]).selected = YES;
     ((UIButton *)[self viewWithTag:11]).titleLabel.font = [UIFont boldSystemFontOfSize:18];
    for (int i = 1; i < _titleArray.count; i ++) {
        UIView *view = [[UIView alloc]init];
        view.tag = 20 + i;
        [self addSubview:view];
//        view.backgroundColor = [UIColor colorFromHexString:@"#0db09b"];
        view.backgroundColor = [UIColor clearColor];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_titleArray) {
        _titleArray = @[@"3"];
    }
    CGFloat btnWidth = TWitdh/_titleArray.count;
    CGFloat btnHeight = self.frame.size.height - markHeight;
    //移动标记

    self.markImageView.frame = CGRectMake(btnWidth * (mark - 1) + btnWidth/2. - markHeight/2., self.frame.size.height - markHeight, markHeight, markHeight);
//    if (_titleArray.count > 2) {
//        self.markImageView.image = [UIImage imageNamed:@"switch1"];
//    }else{
//        self.markImageView.image = [UIImage imageNamed:@"switch"];
//    }

    CGFloat segmentWidth = 1;
    CGFloat segmentHeight = 10;
    for (int i = 0; i < _titleArray.count; i++) {
        [self viewWithTag:i + 11].frame = CGRectMake(i*btnWidth , 0, btnWidth, btnHeight);
        [self viewWithTag:i + 21].frame = CGRectMake( (i+1) *btnWidth, (btnHeight - segmentHeight)/2, segmentWidth, segmentHeight);
    }
    self.backgroundColor = [UIColor clearColor];
    
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        mark = 1;
        [self setUI];
    }
    return self;
}



- (void )setUI
{
    markHeight = 12;
    CGFloat btnWidth = TWitdh/_titleArray.count;
    self.markImageView = [[UIImageView alloc]init];
    self.markImageView.frame = CGRectMake(0, self.frame.size.height - markHeight, btnWidth, markHeight);
    self.markImageView.image = [UIImage imageNamed:@"icon_mark"];
    [self addSubview:self.markImageView];
}

- (void )sortBtn:(UIButton *)sender
{
    if (sender.tag == 15) {
        if ([self.delegate respondsToSelector:@selector(sortBtnDselect:withSortId:)]&&!sender.selected) {
            [self.delegate sortBtnDselect:self withSortId:[NSString stringWithFormat:@"%d",5]];
        }
        return;
        
    }
    mark = sender.tag  - 10;
 
    if ([self.delegate respondsToSelector:@selector(sortBtnDselect:withSortId:)]&&!sender.selected) {
            [self.delegate sortBtnDselect:self withSortId:[NSString stringWithFormat:@"%d",mark]];
    }
    for (int i = 11; i < _titleArray.count + 11; i ++) {
        ((UIButton *)[self viewWithTag:i]).selected = NO;
        ((UIButton *)[self viewWithTag:i]).titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self setNeedsLayout];
}

- (void)selectItem:(NSInteger )index
{
//    [self sortBtn:(UIButton *)[self viewWithTag:index + 11]];
    
    mark = index + 1;
    for (int i = 11; i < _titleArray.count + 11; i ++) {
        ((UIButton *)[self viewWithTag:i]).selected = NO;
        ((UIButton *)[self viewWithTag:i]).titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    ((UIButton *)[self viewWithTag:index + 11]).selected = YES;
    ((UIButton *)[self viewWithTag:index + 11]).titleLabel.font = [UIFont boldSystemFontOfSize:18];

    [self setNeedsLayout];
}

@end

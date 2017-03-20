//
//  ShellCoinPageControlView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//


#define ShellCoinPageControlView_DefaultWidth 6
#define ShellCoinPageControlView_DefaultHeight ShellCoinPageControlView_DefaultWidth

#define ShellCoinPageControlView_BigWidth 10
#define ShellCoinPageControlView_BigHeight 4
#define ShellCoinPageControlView_DefaultMargin 8

#import "ShellCoinPageControlView.h"

@interface ShellCoinPageControlView()

@end

@implementation ShellCoinPageControlView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.backgroundColor = [UIColor cyanColor];
        
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    
    UIView *view = [self viewWithTag:100];
    
    for (int i = 0; i < _numberPages; i ++) {
        if (i == _currentPage) {
            ((UIImageView *)[view viewWithTag:i + 10]).image  = [UIImage imageNamed:@"pagecurrent"];
            if (i ==0) {
                ((UIImageView *)[view viewWithTag:i+ 10]).frame = CGRectMake(0, (self.frame.size.height - ShellCoinPageControlView_BigHeight)/2., ShellCoinPageControlView_BigWidth, ShellCoinPageControlView_BigHeight);
            }else{
                ((UIImageView *)[view viewWithTag:i+ 10]).frame = CGRectMake(CGRectGetMaxX([view viewWithTag:10+i -1].frame) + ShellCoinPageControlView_DefaultMargin, (self.frame.size.height - ShellCoinPageControlView_BigHeight)/2., ShellCoinPageControlView_BigWidth, ShellCoinPageControlView_BigHeight);
            }
            
        }else{
            ((UIImageView *)[view viewWithTag:i + 10]).image  = [UIImage imageNamed:@"pagedefault"];

            if (i == 0) {
                ((UIImageView *)[view viewWithTag:i + 10]).frame = CGRectMake(0, (self.frame.size.height - ShellCoinPageControlView_DefaultHeight)/2., ShellCoinPageControlView_DefaultWidth, ShellCoinPageControlView_DefaultHeight);
            }else{
                ((UIImageView *)[view viewWithTag:i + 10]).frame = CGRectMake(CGRectGetMaxX([view viewWithTag:10+i -1].frame) + ShellCoinPageControlView_DefaultMargin, (self.frame.size.height - ShellCoinPageControlView_DefaultHeight)/2., ShellCoinPageControlView_DefaultWidth, ShellCoinPageControlView_DefaultHeight);
            }
        }
    }
}


- (void)setNumberPages:(NSInteger)numberPages
{
    _numberPages = numberPages;
    UIView *view = [[UIView alloc]init];
    CGFloat viewWidth = ShellCoinPageControlView_BigWidth + (_numberPages - 1)*(ShellCoinPageControlView_DefaultMargin+ShellCoinPageControlView_DefaultWidth);
    view.frame = CGRectMake((TWitdh - viewWidth)/2., 0, viewWidth, self.frame.size.height);
    view.tag = 100;
    [self addSubview:view];
    for (int i = 0; i < _numberPages; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = i + 10;
        [view addSubview:imageView];
        if (imageView.tag == 10) {
            imageView.frame = CGRectMake(0, (self.frame.size.height - ShellCoinPageControlView_BigHeight)/2., ShellCoinPageControlView_BigWidth, ShellCoinPageControlView_BigHeight);
            imageView.image = [UIImage imageNamed:@"pagecurrent"];
        }else{
            imageView.frame = CGRectMake(CGRectGetMaxX([view viewWithTag:10+i -1].frame) + ShellCoinPageControlView_DefaultMargin, (self.frame.size.height - ShellCoinPageControlView_DefaultHeight)/2., ShellCoinPageControlView_DefaultWidth, ShellCoinPageControlView_DefaultHeight);
            imageView.image = [UIImage imageNamed:@"pagedefault"];

        }
    }
}





@end

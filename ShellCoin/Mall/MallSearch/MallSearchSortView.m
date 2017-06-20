
//
//  TypeView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "MallSearchSortView.h"

@implementation MallSearchSortView
-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename andSortImage:(NSString *)imagename
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *starImage = [[UIImageView alloc]initWithFrame:CGRectMake(17, 17, 16, 16*(23/28.))];
        starImage.image = [UIImage imageNamed:imagename];
        starImage.bounds = CGRectMake(0, 0, 17*([UIImage imageNamed:imagename].size.width/[UIImage imageNamed:imagename].size.height), 17);
        [self addSubview:starImage];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starImage.frame) + 12, 10, 200, 20)];
        lab.center = CGPointMake(lab.center.x, starImage.center.y);
        lab.text = typename;
        lab.textColor = MacoDetailColor;
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        BOOL  isLineReturn = NO;
        float upX = 20;
        float upY = 45;
        for (int i = 0; i<arr.count; i++) {
            NSString *str = [arr objectAtIndex:i] ;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:13] forKey:NSFontAttributeName];
            CGSize size = [str sizeWithAttributes:dic];
            //NSLog(@"%f",size.height);
            if ( upX > (self.frame.size.width-40 - size.width-35)) {
                isLineReturn = YES;
                upX = 20;
                upY += 30;
            }
            UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(upX, upY, size.width+30,25);
            if (size.width > TWitdh - 40) {
                btn.frame = CGRectMake(upX, upY, TWitdh - 40,25);

            }
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:MacoTitleColor forState:0];
            [btn setTitleColor:MacoTitleColor forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn setTitle:[arr objectAtIndex:i] forState:0];
            [btn.layer setMasksToBounds:YES];
            [self addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            upX+=size.width+35;
        }
        
//        UIButton *button = [self viewWithTag:100];
//        button.selected = YES;
//        button.backgroundColor = MacoColor;
//        button.layer.borderColor = MacoColor.CGColor;
        
        upY +=30;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+10, self.frame.size.width - 40, 0.5)];
        line.backgroundColor = MacoIntrodouceColor;
        line.tag = 500;
        [self addSubview:line];
        
        self.height = upY+11;
        
        self.seletIndex = -1;
    }
    return self;
}
- (void)setIsLineHidde:(BOOL)isLineHidde
{
    _isLineHidde = isLineHidde;
    [self viewWithTag:500].hidden = _isLineHidde;
}

-(void)touchbtn:(UIButton *)btn
{

    if ([self.delegate respondsToSelector:@selector(btn:withIndex:)]) {
        [self.delegate btn:btn withIndex:(int)btn.tag-100];
    }
    
//    if (btn.selected == NO) {
//        self.seletIndex = (int)btn.tag-100;
//        btn.backgroundColor = [UIColor redColor];
//    }else
//    {
//        self.seletIndex = -1;
//        btn.selected = NO;
//        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    }

//    [self.delegate btnindex:(int)btn.tag-100];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

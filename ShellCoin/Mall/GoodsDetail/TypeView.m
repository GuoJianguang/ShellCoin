
//
//  TypeView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView
-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename
{
    self = [super initWithFrame:frame];
    if (self) {

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        lab.text = typename;
        lab.textColor = MacoDetailColor;
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        BOOL  isLineReturn = NO;
        float upX = 20;
        float upY = 40;
        for (int i = 0; i<arr.count; i++) {
            NSString *str = [arr objectAtIndex:i][@"specVal"] ;
            
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
            [btn setTitleColor:MacoDetailColor forState:0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn setTitle:[arr objectAtIndex:i][@"specVal"] forState:0];
            btn.layer.cornerRadius = 5;
            btn.layer.borderColor = MacoDetailColor.CGColor;
            btn.layer.borderWidth = 1;
            [btn.layer setMasksToBounds:YES];
            [self addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            upX+=size.width+35;
        }
        
        UIButton *button = [self viewWithTag:100];
        button.selected = YES;
        button.backgroundColor = MacoColor;
        button.layer.borderColor = MacoColor.CGColor;
        
        upY +=30;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, upY+10, self.frame.size.width - 40, 0.5)];
        line.backgroundColor = MacoDetailColor;
        line.alpha = 0.4;
        [self addSubview:line];
        self.height = upY+11;
        self.seletIndex = -1;
    }
    return self;
}
-(void)touchbtn:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    btn.backgroundColor = MacoColor;
    if ([self.delegate respondsToSelector:@selector(btn:withIndex:withSelf:)]) {
        [self.delegate btn:btn withIndex:(int)btn.tag-100 withSelf:self];
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

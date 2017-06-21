//
//  ChooseGoodsTypeView.m
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ChooseGoodsTypeView.h"
#import "TypeView.h"
#import "MallSureOrderViewController.h"

@interface ChooseGoodsTypeView()<TypeSeleteDelegete>

@end

@implementation ChooseGoodsTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ChooseGoodsTypeView" owner:nil options:nil][0];
        self.backView.backgroundColor = [UIColor colorFromHexString:@"#f2f2f2f2"];
        self.backView.alpha = 0.8;
        [self sendSubviewToBack:self.backView];
        self.backgroundColor = [UIColor clearColor];
        self.scrollView.bounces = YES;
        self.scrollView.pagingEnabled = YES;
        [self addTypeView];
    }
    return self;
}



#pragma mark - 确定按钮
- (IBAction)sureBtn:(UIButton *)sender {
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self.viewController presentViewController:navc animated:YES completion:NULL];
        return;
    }
    
    MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
    [self.viewController.navigationController pushViewController:sureVC animated:YES];
    
}

- (void)addTypeView
{
    
    NSArray *guigeArray = @[@{@"specList":@[@"黑色／珊瑚红／白",@"黑色／珊瑚红／白",@"黑色／珊瑚红／白"],@"specAttr":@"颜色分类"},
                            @{@"specList":@[@"黑色／珊瑚红／白",@"006纯白色／黑／柿子红",@"我的空间啊空间打开进风口看见可大可久饭卡肌肤抵抗"],@"specAttr":@"商品分类"},
                            @{@"specList":@[@"22",@"23",@"24",@"25",@"26",@"27"],@"specAttr":@"尺码分类"}];
    CGFloat numbertop = 0;
    for (int i = 0; i < guigeArray.count; i ++) {
        TypeView *view = [[TypeView alloc]initWithFrame:CGRectMake(0, 40, TWitdh, 50) andDatasource:guigeArray[i][@"specList"] :guigeArray[i][@"specAttr"]];
        view.tag = i + 10;
        view.delegate = self;
        [self.scrollContentView addSubview:view];
        if (i>0) {
            CGFloat viewY = CGRectGetMaxY([self.scrollContentView viewWithTag:view.tag-1].frame);
            view.frame = CGRectMake(0, viewY, TWitdh, view.height);
        }
        view.bounds = CGRectMake(0, 0, TWitdh, view.height);
        numbertop += view.height;
    }
    if (numbertop == 0) {
        return;
    }
    self.numberViewTop.constant = numbertop + 25;
    self.scrollviewContentHeight.constant = numbertop + TWitdh*(10/75.) + 25;
    self.scrollView.contentSize = CGSizeMake(TWitdh, numbertop + TWitdh*(10/75.) + 25);
}

- (void)btn:(UIButton *)button withIndex:(int)tag
{
    for (id  btn in button.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            ((UIButton *) btn).selected = NO;
            ((UIButton *) btn).backgroundColor = [UIColor whiteColor];
            ((UIButton *) btn).layer.borderColor = MacoIntrodouceColor.CGColor;
        }
    }
    button.selected= YES;
    button.backgroundColor = MacoColor;
    button.layer.borderColor = MacoColor.CGColor;
    
//    //设置请求当前已选中商品价格的参数
//    NSString *temp = [NSString string];
//    for (NSDictionary *dic in self.guigeArray) {
//        for (NSString *str in dic[@"specList"]) {
//            if ([button.titleLabel.text isEqualToString:str]) {
//                temp = dic[@"specAttr"];
//                break;
//            }
//        }
//    }
//    
//    [self.priceParms setObject:button.titleLabel.text forKey:temp];
//    NSString *tempSelectStr = [NSString string];
//    for (NSString *str in self.priceParms.allValues) {
//        tempSelectStr =  [tempSelectStr stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
//    }
//    if (![tempSelectStr isEqualToString:@""]) {
//        tempSelectStr  = [tempSelectStr substringFromIndex:1];
//    }
//    self.yetSelectLabel.text = [NSString stringWithFormat:@"已选: %@",tempSelectStr];
//    //请求当前已选中规格商品价格
//    [self getGoodsPrice];
}

- (IBAction)cancelBtn:(UIButton *)sender {
    [self removeFromSuperview];
}


- (IBAction)subBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];
    if (count == 1) {
        return;
    }
    
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",--count ];
    
}
- (IBAction)addBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];
    
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",++count];
    
}

@end

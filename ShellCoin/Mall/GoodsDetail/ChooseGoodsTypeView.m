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
        self.scrollView.pagingEnabled = NO;
    }
    return self;
}

- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    
    [self getSqec:_goodsId];
}

#pragma mark - 获取商品规格

- (void)getSqec:(NSString *)goodsId
{
    NSDictionary *prams = @{@"id":NullToSpace(goodsId)};
    [HttpClient POST:@"shop/goodsSpec/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = [NSArray array];
            if ([jsonObject[@"data"] isKindOfClass:[NSArray class]]) {
                array = jsonObject[@"data"];
                [self addTypeView:array];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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

- (void)addTypeView:(NSArray *)guigeArray
{
    if (guigeArray.count >0) {

        CGFloat numbertop = 0;
        for (int i = 0; i < guigeArray.count; i ++) {
            TypeView *view = [[TypeView alloc]initWithFrame:CGRectMake(0, 40, TWitdh, 50) andDatasource:guigeArray[i][@"typeValue"] :guigeArray[i][@"typeName"]];
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
        self.numberViewTop.constant = numbertop + 15;
        self.scrollviewContentHeight.constant = numbertop + TWitdh*(20/75.) + 50;
//        self.scrollView.contentSize = CGSizeMake(TWitdh, numbertop + TWitdh*(10/75.) + 50);
    }
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

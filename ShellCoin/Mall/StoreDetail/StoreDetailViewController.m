//
//  StoreDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "StoreRootDetailView.h"
#import "StoreAllGoodsView.h"

@interface StoreDetailViewController ()
@property (nonatomic, strong)StoreRootDetailView *storeRootView;
@property (nonatomic, strong)StoreAllGoodsView *allGoodsView;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"店铺详情";
    self.storeIcon.image = [UIImage imageNamed:@"btn_dianpu"];
    self.storeRootLabel.textColor = MacoColor;
    self.storeRootLineView.backgroundColor = MacoColor;
    
    self.goodsNum.textColor = MacoTitleColor;
    self.allGoodsLabel.textColor = MacoDetailColor;
    self.allGoodsLine.backgroundColor = [UIColor colorFromHexString:@"#eaeaea"];
    self.line.backgroundColor = [UIColor colorFromHexString:@"#eaeaea"];
    
    [self.allGoodsView removeFromSuperview];
    [self.itmeView addSubview:self.storeRootView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.storeRootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itmeView).insets(insets);
    }];
    
    [self getSoteDetail];
}


#pragma mark - 获取店铺信息

- (void)getSoteDetail
{
    NSDictionary *parms = @{@"mchCode":NullToSpace(self.mchCode),
                            @"pageNo":@"1",
                            @"pageSize":@"20"};
    [HttpClient POST:@"shop/merchantShop" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.storeName.text = NullToSpace(jsonObject[@"data"][@"mchName"]);
            self.goodsNum.text = NullToNumber(jsonObject[@"data"][@"goodsCount"]);
            [self.storeImage sd_setImageWithURL:[NSURL URLWithString:NullToSpace(jsonObject[@"data"][@"converImage"])] placeholderImage:LoadingErrorDefaultHearder];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (StoreRootDetailView *)storeRootView
{
    if (!_storeRootView) {
        _storeRootView = [[StoreRootDetailView alloc]init];
    }
    _storeRootView.mchCode = self.mchCode;
    return _storeRootView;
}

- (StoreAllGoodsView *)allGoodsView
{
    if(!_allGoodsView ){
        _allGoodsView = [[StoreAllGoodsView alloc]init];
    }
    _allGoodsView.mchCode = self.mchCode;
    return _allGoodsView;
}

- (IBAction)storeRootBtn:(UIButton *)sender {
    
    self.storeIcon.image = [UIImage imageNamed:@"btn_dianpu"];
    self.storeRootLabel.textColor = MacoColor;
    self.storeRootLineView.backgroundColor = MacoColor;
    
    self.goodsNum.textColor = MacoTitleColor;
    self.allGoodsLabel.textColor = MacoDetailColor;
    self.allGoodsLine.backgroundColor = [UIColor colorFromHexString:@"#eaeaea"];
    
    [self.allGoodsView removeFromSuperview];
    [self.itmeView addSubview:self.storeRootView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.storeRootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itmeView).insets(insets);
    }];
    
}
- (IBAction)allGoodsBtn:(UIButton *)sender {
    
    self.storeIcon.image = [UIImage imageNamed:@"btn_dianputubiao"];
    self.storeRootLabel.textColor = MacoDetailColor;
    self.storeRootLineView.backgroundColor = [UIColor colorFromHexString:@"#eaeaea"];
    
    self.goodsNum.textColor = MacoColor;
    self.allGoodsLabel.textColor = MacoColor;
    self.allGoodsLine.backgroundColor = MacoColor;
    [self.storeRootView removeFromSuperview];
    [self.itmeView addSubview:self.allGoodsView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.allGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itmeView).insets(insets);
    }];
}
@end

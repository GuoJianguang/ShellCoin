//
//  GoodsDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ShoppingCarViewController.h"
#import "ChooseGoodsTypeView.h"
#import "StoreDetailViewController.h"

@interface GoodsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)ChooseGoodsTypeView *chooseTypeView;

@property (nonatomic, copy)NSString *mchCode;

@property (nonatomic, copy)NSString *goodsFrieght;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    self.webView.delegate = self;
    NSURL  *url = [NSURL URLWithString:self.htmlUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    self.mchCode = [NSString string];
    self.goodsFrieght = [NSString string];

    if (self.isFormStore) {
        [self.checkStoreBtn setTitle:@" 返回店铺" forState:UIControlStateNormal];
    }else{
        [self.checkStoreBtn setTitle:@" 进入店铺" forState:UIControlStateNormal];

    }
    
    [self getGoodsDetail];
}

- (ChooseGoodsTypeView *)chooseTypeView
{
    if (!_chooseTypeView) {
        _chooseTypeView = [[ChooseGoodsTypeView alloc]init];
        _chooseTypeView.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _chooseTypeView;
}

#pragma mark - 获取商品详情
- (void)getGoodsDetail{
    NSDictionary *prams = @{@"id":NullToSpace(self.goodsId)};
    [HttpClient POST:@"shop/goods/detail/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.mchCode = NullToSpace(jsonObject[@"data"][@"mchCode"]);
            self.goodsFrieght = NullToSpace(jsonObject[@"data"][@"freight"]);
            self.goodsModel = [MallGoodsModel modelWithDic:jsonObject[@"data"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark - webview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
        [SVProgressHUD showWithStatus:@"正在加载..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
        [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [SVProgressHUD dismiss];
    [[JAlertViewHelper shareAlterHelper]showTint:@"商品信息加载失败" duration:1.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//返回按钮
- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//查看购物车
- (IBAction)shoppcarBtn:(UIButton *)sender {
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self presentViewController:navc animated:YES completion:NULL];
        return;
    }
    ShoppingCarViewController *shoppCarVC = [[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:shoppCarVC animated:YES];
}
//返回首页
- (IBAction)rootPageBtn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//查看店铺
- (IBAction)checkStoreBtn:(UIButton *)sender {
    if (self.isFormStore) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        StoreDetailViewController *storeDetailVC = [[StoreDetailViewController alloc]init];
        storeDetailVC.mchCode = self.mchCode;
        [self.navigationController pushViewController:storeDetailVC animated:YES];
    }
    

    
}
//加入购物车
- (IBAction)addShoppCarBtn:(UIButton *)sender {
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self presentViewController:navc animated:YES completion:NULL];
        return;
    }
    self.chooseTypeView.goodsId = NullToNumber(self.goodsId);
    self.chooseTypeView.goodsFreight = NullToNumber(self.goodsFrieght);
    self.chooseTypeView.chooseType = ChoosType_car;
    self.chooseTypeView.goodsModel = self.goodsModel;
    [self.view addSubview:self.chooseTypeView];

}
//立即购买
- (IBAction)buyBtn:(UIButton *)sender {
    self.chooseTypeView.goodsId = NullToNumber(self.goodsId);
    self.chooseTypeView.goodsFreight = NullToNumber(self.goodsFrieght);
    self.chooseTypeView.chooseType = ChoosType_buy;
    self.chooseTypeView.goodsModel = self.goodsModel;
    [self.view addSubview:self.chooseTypeView];

}
@end

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

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    self.webView.delegate = self;
    self.htmlUrl = @"https://www.baidu.com";
    NSURL  *url = [NSURL URLWithString:self.htmlUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

- (ChooseGoodsTypeView *)chooseTypeView
{
    if (!_chooseTypeView) {
        _chooseTypeView = [[ChooseGoodsTypeView alloc]init];
        _chooseTypeView.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _chooseTypeView;
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
    ShoppingCarViewController *shoppCarVC = [[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:shoppCarVC animated:YES];
}
//返回首页
- (IBAction)rootPageBtn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//查看店铺
- (IBAction)checkStoreBtn:(UIButton *)sender {
    StoreDetailViewController *storeDetailVC = [[StoreDetailViewController alloc]init];
    [self.navigationController pushViewController:storeDetailVC animated:YES];
    
}
//加入购物车
- (IBAction)addShoppCarBtn:(UIButton *)sender {
    
}
//立即购买
- (IBAction)buyBtn:(UIButton *)sender {
    [self.view addSubview:self.chooseTypeView];
    
}
@end

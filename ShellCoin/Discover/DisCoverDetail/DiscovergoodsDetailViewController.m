//
//  DiscovergoodsDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscovergoodsDetailViewController.h"
#import "SelectGoodsNumberView.h"

@interface DiscovergoodsDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)SelectGoodsNumberView *selectNumberView;

@end

@implementation DiscovergoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    NSURL  *url = [NSURL URLWithString:self.htmlUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - webview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    [SVProgressHUD showWithStatus:@"正在加载..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [SVProgressHUD dismiss];
    [[JAlertViewHelper shareAlterHelper]showTint:@"商品信息加载失败" duration:1.5];
}
- (SelectGoodsNumberView *)selectNumberView
{
    if (!_selectNumberView) {
        _selectNumberView = [[SelectGoodsNumberView alloc]init];
    }
    return _selectNumberView;
}


- (IBAction)buyBtn:(UIButton *)sender {
    [self.view addSubview:self.selectNumberView];
    self.selectNumberView.goodsId = self.goodsid;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.selectNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.selectNumberView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.selectNumberView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
    
}
- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

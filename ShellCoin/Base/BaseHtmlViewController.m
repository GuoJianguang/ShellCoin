//
//  BaseHtmlViewController.m
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseHtmlViewController.h"

@interface BaseHtmlViewController ()<UIWebViewDelegate>

@end

@implementation BaseHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviBar.title = self.htmlTitle;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, TWitdh, THeight-64)];
    [self.view addSubview:self.webView];
    
    NSURL  *url = [NSURL URLWithString:self.htmlUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
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
    [[JAlertViewHelper shareAlterHelper]showTint:@"加载失败" duration:1.5];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

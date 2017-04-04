//
//  BaseHtmlViewController.h
//  天添薪
//
//  Created by ttx on 16/1/11.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseHtmlViewController : BaseViewController


@property (strong, nonatomic)UIWebView *webView;

@property (nonatomic, strong)NSString *htmlUrl;

@property (nonatomic, strong)NSString *htmlTitle;

@property (nonatomic, assign)BOOL  isAboutMerChant;
@property (nonatomic, copy)NSString *merchantCode;

@end

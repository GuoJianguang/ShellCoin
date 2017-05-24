//
//  DiscovergoodsDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscovergoodsDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

- (IBAction)buyBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(UIButton *)sender;

@property (nonatomic,copy)NSString *htmlUrl;

@end

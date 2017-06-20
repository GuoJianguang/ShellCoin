//
//  GoodsDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)backBtn:(UIButton *)sender;

- (IBAction)shoppcarBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rootPageBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoppcarBtn;

- (IBAction)rootPageBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkStoreBtn;
- (IBAction)checkStoreBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addShoppCarBtn;
- (IBAction)addShoppCarBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
- (IBAction)buyBtn:(UIButton *)sender;


@property (nonatomic,copy)NSString *htmlUrl;


@end

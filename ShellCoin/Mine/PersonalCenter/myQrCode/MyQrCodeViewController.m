//
//  MyQrCodeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyQrCodeViewController.h"

@interface MyQrCodeViewController ()

@end

@implementation MyQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.view.backgroundColor = [UIColor redColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  返回按钮
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  分享功能

- (IBAction)shareBtn:(id)sender {
}
@end

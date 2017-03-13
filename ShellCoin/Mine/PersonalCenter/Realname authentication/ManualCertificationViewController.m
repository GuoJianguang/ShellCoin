//
//  ManualCertificationViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManualCertificationViewController.h"

@interface ManualCertificationViewController ()<BasenavigationDelegate>

@end

@implementation ManualCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailTitle = @"提交";
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}

#pragma mark - 提交
- (void)detailBtnClick
{
    
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

- (IBAction)idCardBtn:(id)sender {
}
@end

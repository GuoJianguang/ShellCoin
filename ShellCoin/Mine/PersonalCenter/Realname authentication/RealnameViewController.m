//
//  RealnameViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RealnameViewController.h"
#import "RealNameAutResultView.h"

@interface RealnameViewController ()<BasenavigationDelegate>

@property (nonatomic, strong)RealNameAutResultView *resultView;

@end

@implementation RealnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"实名认证";
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailTitle = @"提交";
    
}

- (RealNameAutResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[RealNameAutResultView alloc]init];
    }
    return _resultView;
}

#pragma mark - 实名认证提交
- (void)detailBtnClick
{
    self.resultView.isSuccess = NO;
    [self.view addSubview:self.resultView];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}


- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
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

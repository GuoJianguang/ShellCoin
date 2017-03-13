//
//  RecommentEarningsViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommentEarningsViewController.h"
#import "RecommendTableViewCell.h"
#import "MyQrCodeViewController.h"

@interface RecommentEarningsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation RecommentEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.talbeView.backgroundColor = [UIColor clearColor];
    __weak RecommentEarningsViewController *weak_self = self;
    self.talbeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.talbeView.mj_header endRefreshing];
    }];
    self.talbeView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self.talbeView.mj_footer endRefreshing];
    }];

}


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommendTableViewCell indentify]];
    if (!cell) {
        cell = [RecommendTableViewCell newCell];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(170/750.);
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 推广码
- (IBAction)qrcodeBtn:(id)sender {
    MyQrCodeViewController *myQrVC = [[MyQrCodeViewController alloc]init];
    [self.navigationController pushViewController:myQrVC animated:YES];
}
@end

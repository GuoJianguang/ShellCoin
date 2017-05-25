//
//  SureDiscoverOrderViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureDiscoverOrderViewController.h"
#import "SureDiscoverOrderTableViewCell.h"

@interface SureDiscoverOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SureDiscoverOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"确认订单";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SureDiscoverOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SureDiscoverOrderTableViewCell indentify]];
    if (!cell) {
        cell = [SureDiscoverOrderTableViewCell newCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (TWitdh-24)*(24/17.) + 60;
}


- (IBAction)sureBtn:(UIButton *)sender {
}
@end

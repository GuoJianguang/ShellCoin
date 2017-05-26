//
//  MyQrCodeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverQrCodeViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import <ZYCornerRadius/UIImageView+CornerRadius.h>
#import <UShareUI/UShareUI.h>
#import "DIiscoverQrCodeTableViewCell.h"
@interface DiscoverQrCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DiscoverQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (THeight < 500) {
        return 575;
    }
    return THeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIiscoverQrCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DIiscoverQrCodeTableViewCell indentify]];
    if (!cell) {
        cell = [DIiscoverQrCodeTableViewCell newCell];
    }
    cell.goodsId = self.goodsId;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end

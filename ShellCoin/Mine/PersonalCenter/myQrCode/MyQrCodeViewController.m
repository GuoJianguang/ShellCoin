//
//  MyQrCodeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyQrCodeViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import <ZYCornerRadius/UIImageView+CornerRadius.h>
#import <UShareUI/UShareUI.h>
#import "MyQrCodeTableViewCell.h"
@interface MyQrCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyQrCodeViewController

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
    MyQrCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyQrCodeTableViewCell indentify]];
    if (!cell) {
        cell = [MyQrCodeTableViewCell newCell];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end

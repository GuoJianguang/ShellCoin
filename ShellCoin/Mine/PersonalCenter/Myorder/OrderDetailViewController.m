//
//  OrderDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

@interface OrderDetailViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title= @"查看订单";
    self.naviBar.detailTitle = @"联系客服";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    
    
}

//联系客服
- (void)detailBtnClick
{
    
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderDetailTableViewCell indentify]];
    if (!cell) {
        cell = [OrderDetailTableViewCell newCell];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return TWitdh * (600/320.);
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

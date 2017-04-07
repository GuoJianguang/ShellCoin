//
//  PersonCenterViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonCenterTableViewCell.h"

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource,BasenavigationDelegate>

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    self.naviBar.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(realNameSuccess) name:@"realNameSuccess" object:nil];

}



- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"realNameSuccess" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)realNameSuccess
{
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PersonCenterTableViewCell indentify]];
    if (!cell) {
        cell = [PersonCenterTableViewCell newCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return THeight;
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

//
//  EditBankInfoViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditBankInfoViewController.h"
#import "EditbankInfoTableViewCell.h"

@interface EditBankInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EditBankInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"编辑银行卡";
}



#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditbankInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditbankInfoTableViewCell indentify]];
    if (!cell) {
        cell = [EditbankInfoTableViewCell newCell];
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

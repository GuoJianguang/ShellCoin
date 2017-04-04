//
//  MessageDetailViewController.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailTableViewCell.h"
#import "UILabel+StringFrame.h"


@interface MessageDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"消息详情";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
}

#pragma mark - UITableView


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self cellHeight:self.dataModel.content] + 135 > 300) {
        return [self cellHeight:self.dataModel.content] + 135;
    }
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailTableViewCell *cell = (MessageDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MessageDetailTableViewCell indentify]];
    if (!cell) {
        cell = [MessageDetailTableViewCell newCell];
    }
    cell.dataModel = self.dataModel;
    
    return cell;
}

- (CGFloat)cellHeight:(NSString *)textSting
{
    CGSize size = [textSting boundingRectWithSize:CGSizeMake(TWitdh - 30, 0) font:[UIFont systemFontOfSize:14]];
    return size.height;
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

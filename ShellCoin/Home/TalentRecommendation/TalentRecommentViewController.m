//
//  TalentRecommentViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TalentRecommentViewController.h"
#import "HomeMerchantTableViewCell.h"
#import "RecommentSpecialTableViewCell.h"
#import "RecommentModel.h"

@interface TalentRecommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *datasouceArray;

@end

@implementation TalentRecommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"达人推荐";
    RecommentModel *model1 = [[RecommentModel alloc]init];
    model1.type = 1;
    RecommentModel *model2 = [[RecommentModel alloc]init];
    model2.type = 2;
    
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model2];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model2];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model2];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.datasouceArray addObject:model1];
    [self.tableView reloadData];

    
}

- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommentModel *model = self.datasouceArray[indexPath.row];
    
    switch (model.type) {
        case 1:
        {
            HomeMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeMerchantTableViewCell indentify]];
            if (!cell) {
                cell = [HomeMerchantTableViewCell newCell];
            }
            return cell;
        }
            break;
            case 2:
        {
            RecommentSpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommentSpecialTableViewCell indentify]];
            if (!cell) {
                cell = [RecommentSpecialTableViewCell newCell];
            }
            return cell;
        }
            break;
        default:
    
            break;
    }
    return nil;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommentModel *model = self.datasouceArray[indexPath.row];
    
    switch (model.type) {
        case 1:
        {
            return TWitdh*(95/320.);

        }
            break;
        case 2:
        {
            return TWitdh*(130/320.);
            
        }
            break;
        default:
            break;
    }
    return TWitdh*(95/320.);

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

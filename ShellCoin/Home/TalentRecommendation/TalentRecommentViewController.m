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
    __weak TalentRecommentViewController *weak_self = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self getPersonalRequest];
    }];
    [self.tableView noDataSouce];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}


- (void)getPersonalRequest{
    
    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude)),
                            @"flag":@"1"};
    [HttpClient POST:@"user/personal" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [self.tableView.mj_header endRefreshing];
        if (IsRequestTrue) {
            [self.datasouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (int i = 0; i < array.count; i++) {
                RecommentModel *model = [RecommentModel modelWithDic:array[i]];
                if (i%3==0 && i!=0 &&model.picArray.count !=0) {
                    model.type = 2;
                }else{
                    model.type = 1;
                }
                [self.datasouceArray addObject:model];
            }
            [self.tableView judgeIsHaveDataSouce:self.datasouceArray];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView showNoDataSouceNoNetworkConnection];
        [self.tableView.mj_header endRefreshing];
    }];
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
            cell.dataModel = self.datasouceArray[indexPath.row];
            return cell;
        }
            break;
            case 2:
        {
            RecommentSpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommentSpecialTableViewCell indentify]];
            if (!cell) {
                cell = [RecommentSpecialTableViewCell newCell];
            }
            cell.dataModel = self.datasouceArray[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommentModel *model = self.datasouceArray[indexPath.row];
    BaseHtmlViewController *htmlVC = [[BaseHtmlViewController alloc]init];
    htmlVC.htmlUrl = model.jumpValue;
    if ([model.remark isEqualToString:@""] ) {
        htmlVC.isAboutMerChant = NO;
    }else{
        htmlVC.isAboutMerChant = YES;
        htmlVC.merchantCode = model.remark;
    }
    htmlVC.htmlTitle = model.name;
    [self.navigationController pushViewController:htmlVC animated:YES];
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

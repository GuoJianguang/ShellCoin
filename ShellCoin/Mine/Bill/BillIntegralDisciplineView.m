//
//  BillIntegralDisciplineView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/22.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillIntegralDisciplineView.h"
#import "BillConsumptionTableViewCell.h"
#import "BillIntegaralModel.h"
#import "IntergralRecordTableViewCell.h"

@interface BillIntegralDisciplineView()<UITableViewDelegate,UITableViewDataSource,SwipeViewDelegate,SwipeViewDataSource>
@property (nonatomic, strong)UITableView *talbeView1;
@property (nonatomic, strong)UITableView *talbeView2;

@property (nonatomic, assign)NSInteger page1;
@property (nonatomic, assign)NSInteger page2;


@property (nonatomic, strong)NSMutableArray *dataSouceArray1;
@property (nonatomic, strong)NSMutableArray *dataSouceArray2;
@end
@implementation BillIntegralDisciplineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BillIntegralDisciplineView" owner:nil options:nil][0];
        self.talbeView1.backgroundColor = self.talbeView2.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.swipeView.delegate = self;
        self.swipeView.dataSource = self;
        self.swipeView.backgroundColor = [UIColor clearColor];

        __weak BillIntegralDisciplineView *weak_self = self;
        
        self.talbeView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page1 = 1;
            [weak_self getIntegralDongtaiRequest:YES];
        }];
        self.talbeView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getIntegralDongtaiRequest:NO];
        }];
        [self.talbeView1.mj_header beginRefreshing];
        
        self.talbeView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page2 = 1;
            [weak_self getShellCoinDongtaiRequest:YES];
        }];
        self.talbeView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getShellCoinDongtaiRequest:NO];
        }];

    }
    return self;
}

- (void)getIntegralDongtaiRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page1),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/accumulateLog/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray1 removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page1 ++;
            }
            for (NSDictionary *dic in array) {
                BillIntegaralModel *model = [BillIntegaralModel modelWithDic:dic];
                [self.dataSouceArray1 addObject:model];
            }
            [self.talbeView1 reloadData];
        }
        if (isHeader) {
            [self.talbeView1.mj_header endRefreshing];
        }else{
            [self.talbeView1.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        if (isHeader) {
            [self.talbeView1.mj_header endRefreshing];
        }else{
            [self.talbeView1.mj_footer endRefreshing];
            
        }
    }];

}

- (void)getShellCoinDongtaiRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page2),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/shellsAmountLog/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray2 removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page2 ++;
            }
            for (NSDictionary *dic in array) {
                IntegralShellCoinModel *model = [IntegralShellCoinModel modelWithDic:dic];
                [self.dataSouceArray2 addObject:model];
            }
            [self.talbeView2 reloadData];
        }
        if (isHeader) {
            [self.talbeView2.mj_header endRefreshing];
        }else{
            [self.talbeView2.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        if (isHeader) {
            [self.talbeView2.mj_header endRefreshing];
        }else{
            [self.talbeView2.mj_footer endRefreshing];
            
        }
    }];

}


#pragma mark - 懒加载
- (UITableView *)talbeView1
{
    if (!_talbeView1) {
        _talbeView1 = [[UITableView alloc]init];
        _talbeView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView1.delegate = self;
        _talbeView1.dataSource = self;
    }
    return _talbeView1;
}
- (UITableView *)talbeView2
{
    if (!_talbeView2) {
        _talbeView2 = [[UITableView alloc]init];
        _talbeView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView2.delegate = self;
        _talbeView2.dataSource = self;
        
    }
    return _talbeView2;
}

- (NSMutableArray *)dataSouceArray1
{
    if (!_dataSouceArray1) {
        _dataSouceArray1 = [NSMutableArray array];
    }
    return _dataSouceArray1;
}

- (NSMutableArray *)dataSouceArray2
{
    if (!_dataSouceArray2) {
        _dataSouceArray2 = [NSMutableArray array];
    }
    return _dataSouceArray2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.talbeView1 == tableView) {
      return self.dataSouceArray1.count;
    }else{
        return self.dataSouceArray2.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntergralRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IntergralRecordTableViewCell indentify]];
    if (!cell) {
        cell = [IntergralRecordTableViewCell newCell];
    }
    if (tableView==self.talbeView1) {
        cell.integaralModel = self.dataSouceArray1[indexPath.row];
    }else{
        cell.shellCoinModel = self.dataSouceArray2[indexPath.row];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(170/750.);

}

#pragma mark - SwipeView
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, swipeView.frame.size.width, swipeView.frame.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 0:{
            [view addSubview:self.talbeView1];
            [self.talbeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.talbeView2];
            [self.talbeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
            
        }
            break;
                default:
            break;
    }
    
    return view;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 2;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    self.switchView.selectedSegmentIndex = swipeView.currentItemIndex;
    switch (swipeView.currentItemIndex) {
        case 0:
        {
            [self.talbeView1.mj_header beginRefreshing];
        }
            break;
        case 1:
        {
            [self.talbeView2.mj_header beginRefreshing];
        }
            
            break;
        default:
            break;
    }
}


- (IBAction)switchView:(id)sender {
    [self.swipeView scrollToPage:self.switchView.selectedSegmentIndex duration:0.5];


}
@end

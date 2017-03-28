//
//  BillAmountDisciplineView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/22.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillAmountDisciplineView.h"
#import "BillConsumptionTableViewCell.h"
#import "BillTableViewCell.h"
#import "BillAmountDataModel.h"

@interface BillAmountDisciplineView ()<SwipeViewDataSource,SwipeViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *talbeView1;
@property (nonatomic, strong)UITableView *talbeView2;
@property (nonatomic, strong)UITableView *talbeView3;

@property (nonatomic, assign)NSInteger page1;
@property (nonatomic, assign)NSInteger page2;
@property (nonatomic, assign)NSInteger page3;


@property (nonatomic, strong)NSMutableArray *dataSouceArray1;
@property (nonatomic, strong)NSMutableArray *dataSouceArray2;
@property (nonatomic, strong)NSMutableArray *dataSouceArray3;


@end
@implementation BillAmountDisciplineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BillAmountDisciplineView" owner:nil options:nil][0];
        self.talbeView1.backgroundColor = self.talbeView2.backgroundColor =self.talbeView3.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.swipeView.delegate = self;
        self.swipeView.dataSource = self;
        __weak BillAmountDisciplineView *weak_self = self;
        
        self.talbeView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page1 = 1;
            [weak_self getxiaofeijiluRequest:YES];
        }];
        self.talbeView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getxiaofeijiluRequest:NO];
        }];
        [self.talbeView1.mj_header beginRefreshing];
        
        self.talbeView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page2 = 1;
            [weak_self getDihuanjiluRequest:YES];
        }];
        self.talbeView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getDihuanjiluRequest:NO];
        }];
        
        self.talbeView3.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page3 = 1;
            [weak_self getTixianjiluRequest:YES];
        }];
        self.talbeView3.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getTixianjiluRequest:NO];
        }];
    }
    return self;
}


- (void)getxiaofeijiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page1),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/bill/consumRecord/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray1 removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page1 ++;
            }
            for (NSDictionary *dic in array) {
                BillAmountDataModel *model = [BillAmountDataModel modelWithDic:dic];
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
- (void)getDihuanjiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page2),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/bill/accumulate/withdraw/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray2 removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page2 ++;
            }
            for (NSDictionary *dic in array) {
                BillDihuanModel *model = [BillDihuanModel modelWithDic:dic];
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
- (void)getTixianjiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page3),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/bill/recommend/withdraw/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray3 removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page3 ++;
            }
            for (NSDictionary *dic in array) {
                BillDihuanModel *model = [BillDihuanModel modelWithDic:dic];
                [self.dataSouceArray3 addObject:model];
            }
            [self.talbeView3 reloadData];
        }
        if (isHeader) {
            [self.talbeView3.mj_header endRefreshing];
        }else{
            [self.talbeView3.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        if (isHeader) {
            [self.talbeView3.mj_header endRefreshing];
        }else{
            [self.talbeView3.mj_footer endRefreshing];
            
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

- (NSMutableArray *)dataSouceArray1
{
    if (!_dataSouceArray1) {
        _dataSouceArray1 = [NSMutableArray array];
    }
    return _dataSouceArray1;
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

- (NSMutableArray *)dataSouceArray2
{
    if (!_dataSouceArray2) {
        _dataSouceArray2 = [NSMutableArray array];
    }
    return _dataSouceArray2;
}

- (UITableView *)talbeView3
{
    if (!_talbeView3) {
        _talbeView3 = [[UITableView alloc]init];
        _talbeView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView3.delegate = self;
        _talbeView3.dataSource = self;
        
    }
    return _talbeView3;
}
- (NSMutableArray *)dataSouceArray3
{
    if (!_dataSouceArray3) {
        _dataSouceArray3 = [NSMutableArray array];
    }
    return _dataSouceArray3;
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
        case 2:{
            [view addSubview:self.talbeView3];
            [self.talbeView3 mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return 3;
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
        case 2:
        {
            [self.talbeView3.mj_header beginRefreshing];
        }
            break;
            
        default:
            break;
    }
}


- (IBAction)switchView:(id)sender {
    [self.swipeView scrollToPage:self.switchView.selectedSegmentIndex duration:0];
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.talbeView1) {
        return self.dataSouceArray1.count;
    }else if (tableView == self.talbeView2){
        return self.dataSouceArray2.count;

    }else{
        return self.dataSouceArray3.count;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.talbeView1 == tableView) {
        return TWitdh*(190/750.);
    }
    return TWitdh*(170/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.talbeView1 == tableView) {
        BillConsumptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillConsumptionTableViewCell indentify]];
        if (!cell) {
            cell = [BillConsumptionTableViewCell newCell];
        }
        cell.xiaofeijiluModel = self.dataSouceArray1[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillTableViewCell indentify]];
    if (!cell) {
        cell = [BillTableViewCell newCell];
    }
    if (self.talbeView2 == tableView) {
//        cell.dihuanModel = self.dataSouceArray2[indexPath.row];
    }
    if (self.talbeView3 == tableView) {
//        cell.dihuanModel = self.dataSouceArray3[indexPath.row];
    }
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end

//
//  StoreRootDetailView.m
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "StoreRootDetailView.h"
#import "MallGoodsCollectionViewCell.h"
#import "GoodsDetailViewController.h"

@interface StoreRootDetailView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, copy)NSString *phone;

@end

@implementation StoreRootDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"StoreRootDetailView" owner:nil options:nil][0];
        self.commendLine.backgroundColor = self.commendLabel.textColor = MacoColor;
        self.phoneLabel.textColor = self.timeLabel.textColor = MacoDetailColor;
        __weak StoreRootDetailView *weak_self = self;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
            [weak_self getRequest:YES];
        }];
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getRequest:NO];
        }];
        [self.collectionView noDataSouce];
        [self reload];
        
    }
    return self;
}

- (void)reload
{
    [self.collectionView reloadData];
}

- (void)setMchCode:(NSString *)mchCode
{
    _mchCode = mchCode;
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - 数据请求
- (void)getRequest:(BOOL )isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"mchCode":NullToSpace(self.mchCode)};
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/merchantShop" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                
                self.phoneLabel.text = [NSString stringWithFormat:@"服务电话:%@",NullToSpace(jsonObject[@"data"][@"contactPhone"])];
                self.timeLabel.text = [NSString stringWithFormat:@"开店时间:%@",NullToSpace(jsonObject[@"data"][@"openTime"])];
                self.phone =NullToSpace(jsonObject[@"data"][@"contactPhone"]);
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"goodsList"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                MallGoodsModel *model = [MallGoodsModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            [self.collectionView reloadData];
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [self.collectionView showNoDataSouceNoNetworkConnection];
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        
    }];

    
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *identifier =[MallGoodsCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [MallGoodsCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    MallGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dataModel = self.dataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc]init];
    goodsDetailVC.htmlUrl = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).detailUrl;
    goodsDetailVC.goodsId = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).goodsId;
    goodsDetailVC.isFormStore = YES;
    [self.viewController.navigationController pushViewController:goodsDetailVC animated:YES];
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((TWitdh- 18)/2., (TWitdh- 18)/2. +  (TWitdh- 18)/2. * (130/355.));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(6, 6, 6, 6);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}


#pragma mark - 打电话
- (IBAction)phoneBtn:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",NullToSpace(self.phone)];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.viewController.view addSubview:callWebview];
}
@end

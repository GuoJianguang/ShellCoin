//
//  MallGoodsListViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallGoodsListViewController.h"
#import "MallGoodsCollectionViewCell.h"
#import "MallSortView.h"
#import "GoodsDetailViewController.h"
#import "MallSearchViewController.h"
#import "HomeIndustryTableViewCell.h"
#import "ShoppingCarViewController.h"

@interface MallGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BasenavigationDelegate,MallSortViewdelegate>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)MallSearchViewController *searchVC;
@property (nonatomic,strong)MallSortView *sortView;
//1:价格降序 2:价格升序 3:销量降序 4:时间降序 5时间升序
@property (nonatomic, assign)NSInteger flag;

@end

@implementation MallGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = NullToSpace(self.typeName);
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_search"];
    self.sortView.hidden = YES;
    self.flag = 0;
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    self.priceBtn.selected = YES;
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    
    [self setSortUI];
 
    if (self.isSearch) {
        self.naviBar.title = @"搜索结果";
    }
    __weak MallGoodsListViewController *weak_self = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getGoodsSearchRequestIsHeader:YES];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getGoodsSearchRequestIsHeader:NO];
        
    }];
    [self.collectionView noDataSouce];
    [self.collectionView.mj_header beginRefreshing];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mallGoodsSearch:) name:@"MallGoodsSearch" object:nil];

}

- (void)setIsSearch:(BOOL)isSearch
{
    _isSearch = isSearch;
    if (_isSearch) {
        self.naviBar.title = @"搜索结果";
    }

}
#pragma mark - 设置分类UI
- (void)setSortUI
{
    [self.sort1Btn setTitle:((NewHomeActivityModel*)self.typeArray[0]).name forState:UIControlStateNormal];
    [self.sort2Btn setTitle:((NewHomeActivityModel *)self.typeArray[1]).name forState:UIControlStateNormal];
    [self.sort3Btn setTitle:((NewHomeActivityModel *)self.typeArray[2]).name forState:UIControlStateNormal];
    
    if ([self.typeId isEqualToString:((NewHomeActivityModel *)self.typeArray[0]).sortId]) {
        [self.sort1Btn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self.sort2Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.sort3Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];

    }else if ([self.typeId isEqualToString:((NewHomeActivityModel *)self.typeArray[1]).sortId]){
        [self.sort2Btn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self.sort1Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.sort3Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    }else if ([self.typeId isEqualToString:((NewHomeActivityModel *)self.typeArray[2]).sortId]){
        [self.sort3Btn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self.sort2Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.sort1Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    }else{
        [self.sort3Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.sort2Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.sort1Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    }
}

#pragma mark -  搜索按钮
- (void)detailBtnClick
{
    [self.navigationController.view addSubview:self.searchVC.view];
    [self.searchVC addTypeView];
}
- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MallGoodsSearch" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
 
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (MallSearchViewController *)searchVC
{
    if (!_searchVC) {
        _searchVC = [[MallSearchViewController alloc]init];
        _searchVC.view.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _searchVC;
}

- (MallSortView *)sortView
{
    if (!_sortView) {
        _sortView = [[MallSortView alloc]init];
        _sortView.frame = CGRectMake(0, 64 + TWitdh *(79/320.), TWitdh, TWitdh *(230/750.));
        _sortView.yetSeletId = self.typeId;
        _sortView.dataSouceArray = self.typeArray;
        _sortView.delegate = self;
    }
    return _sortView;
}
- (void)setTypeId:(NSString *)typeId
{
    _typeId = typeId;
    _sortView.yetSeletId = _typeId;
    _sortView.dataSouceArray = self.typeArray;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//价格优先
- (IBAction)priceBtn:(UIButton *)sender {
    self.timeBtn.selected = YES;
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.flag = 2;
        self.priceImage.image = [UIImage imageNamed:@"btn_shangxueze"];

    }else{
        self.flag = 1;
        self.priceImage.image = [UIImage imageNamed:@"btn_xiaxuanzhong"];

    }
    [self.priceBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.collectionView.mj_header beginRefreshing];

}

//销量降序
- (IBAction)salesBtn:(UIButton *)sender {
    self.timeBtn.selected = YES;
    self.priceBtn.selected = YES;

    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.flag = 3;
    [self.collectionView.mj_header beginRefreshing];

}
//时间优先
- (IBAction)timeBtn:(UIButton *)sender {
    
    self.priceBtn.selected = YES;
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.flag = 5;
        self.timeImage.image = [UIImage imageNamed:@"btn_shangxueze"];
        
    }else{
        self.flag = 4;
        self.timeImage.image = [UIImage imageNamed:@"btn_xiaxuanzhong"];
        
    }
    
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    [self.collectionView.mj_header beginRefreshing];

    
}


- (IBAction)sort1Btn:(UIButton *)sender {
    self.typeId = ((NewHomeActivityModel *)self.typeArray[0]).sortId;
    self.naviBar.title = ((NewHomeActivityModel *)self.typeArray[0]).name;
    [self.sort1Btn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.sort2Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.sort3Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.collectionView.mj_header beginRefreshing];

}
- (IBAction)sort2Btn:(UIButton *)sender {
    self.typeId = ((NewHomeActivityModel *)self.typeArray[1]).sortId;
    self.naviBar.title = ((NewHomeActivityModel *)self.typeArray[1]).name;
    [self.sort2Btn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.sort1Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.sort3Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.collectionView.mj_header beginRefreshing];
}

- (IBAction)sort3Btn:(UIButton *)sender {
    self.typeId = ((NewHomeActivityModel *)self.typeArray[2]).sortId;
    self.naviBar.title = ((NewHomeActivityModel *)self.typeArray[2]).name;
    [self.sort3Btn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.sort2Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.sort1Btn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.collectionView.mj_header beginRefreshing];
}
- (IBAction)moreSortBtn:(UIButton *)sender {
    [self.view addSubview:self.sortView];
    self.sortView.hidden = !self.sortView.hidden;
}

#pragma mark - 点击选择分类
- (void)selectSort:(NSString *)sortId withName:(NSString *)sortName
{
    self.typeId = sortId;
    self.naviBar.title = sortName;
    self.sortView.hidden = YES;
    [self setSortUI];
    [self.collectionView.mj_header beginRefreshing];

}
#pragma mark - 数据请求
- (void)getGoodsSearchRequestIsHeader:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"typeId":NullToSpace(self.typeId),
                            @"keyWords":NullToSpace(self.keyWords),
                            @"flag":@(self.flag)};
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/search" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
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
    cell.dataModel  = self.dataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc]init];
    goodsDetailVC.htmlUrl = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).detailUrl;
    goodsDetailVC.goodsId = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).goodsId;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
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

#pragma mark - 搜索结果
- (void)mallGoodsSearch:(NSNotification *)faication
{
    self.keyWords = NullToSpace(faication.object[@"keyWords"]);
    self.isSearch = YES;
    self.typeId = @"";
    self.flag = 0;
    [self setSortUI];
    [self.collectionView.mj_header beginRefreshing];
}
#pragma mark - 购物车
- (IBAction)buyCarBtn:(UIButton *)sender {
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self presentViewController:navc animated:YES completion:NULL];
        return;
    }
    ShoppingCarViewController *shoppCarVC = [[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:shoppCarVC animated:YES];
}

@end

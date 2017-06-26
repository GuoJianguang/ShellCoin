//
//  MallRootViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallRootViewController.h"
#import "MallRootBannerCollectionViewCell.h"
#import "MallGoodsCollectionViewCell.h"
#import "ShoppingCarViewController.h"
#import "GoodsDetailViewController.h"
#import "MallGoodsModel.h"
#import "HomeIndustryTableViewCell.h"
#import "MallGoodsListViewController.h"

@interface MallRootViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)NSMutableArray *sortDataArray;

@end

@implementation MallRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hidden = YES;
    self.searchTF.delegate = self;
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor  = [UIColor whiteColor].CGColor;
    [self.searchBtn setTitleColor:[UIColor colorFromHexString:@"#a0a0a0"] forState:UIControlStateNormal];
    [self.searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTF.textColor = [UIColor whiteColor];
    
    __weak MallRootViewController *weak_self = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getGoodsListRequestIsHeader:YES];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getGoodsListRequestIsHeader:NO];
        
    }];
    
    [self.collectionView.mj_header beginRefreshing];

    
}


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (NSMutableArray *)sortDataArray
{
    if (!_sortDataArray) {
        _sortDataArray = [NSMutableArray array];
    }
    return _sortDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 搜索
- (IBAction)searchBtn:(UIButton *)sender {
    
    if ([self valueValidated]) {
        [self.searchTF resignFirstResponder];
        NSMutableArray *array = [NSMutableArray array];
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]) {
            array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]];
        }
        if (array.count > 10) {
            [array  removeLastObject];
        }
        if (![array containsObject:self.searchTF.text]) {
            [array insertObject:self.searchTF.text atIndex:0];
            
        }
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"SearchHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        MallGoodsListViewController *listVC = [[MallGoodsListViewController alloc]init];
        listVC.keyWords = self.searchTF.text;
        listVC.isSearch = YES;
        listVC.typeArray = self.sortDataArray;
        [self.navigationController  pushViewController:listVC animated:YES];
    }
}

#pragma mark - 购物车
- (IBAction)buyCarBtn:(UIButton *)sender {
    ShoppingCarViewController *shoppCarVC = [[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:shoppCarVC animated:YES];
}

#pragma mark - 数据请求
- (void)getGoodsListRequestIsHeader:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount
                            };
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient GET:@"shop/index" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.sortDataArray removeAllObjects];
                
                NSArray *sortarray = jsonObject[@"data"][@"goodsTypeList"];
                for (NSDictionary *dic in sortarray) {
                    NewHomeActivityModel *model = [NewHomeActivityModel modelWithDic:dic];
                    [self.sortDataArray addObject:model];
                }
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
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
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
    return self.dataSouceArray.count + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        NSString *identifier =[MallRootBannerCollectionViewCell indentify];
        static BOOL nibri =NO;
        if(!nibri)
        {
            UINib *nib = [MallRootBannerCollectionViewCell newCell];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibri =YES;
        }
        MallRootBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.sortDataSouceArray = self.sortDataArray;
        nibri=NO;
        return cell;
    }
    
    
    NSString *identifier =[MallGoodsCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [MallGoodsCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    MallGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dataModel = self.dataSouceArray[indexPath.item - 1];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return;
    }
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc]init];
    goodsDetailVC.htmlUrl = ((MallGoodsModel *)self.dataSouceArray[indexPath.item - 1]).detailUrl;
    goodsDetailVC.goodsId = ((MallGoodsModel *)self.dataSouceArray[indexPath.item - 1]).goodsId;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return CGSizeMake(TWitdh, TWitdh*(473/750.));
    }
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

#pragma mark - Search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self valueValidated]) {
        [textField resignFirstResponder];
        NSMutableArray *array = [NSMutableArray array];
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]) {
            array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]];
        }
        if (array.count > 10) {
            [array  removeLastObject];
        }
        if (![array containsObject:self.searchTF.text]) {
            [array insertObject:self.searchTF.text atIndex:0];

        }
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"SearchHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        MallGoodsListViewController *listVC = [[MallGoodsListViewController alloc]init];
        listVC.keyWords = self.searchTF.text;
        listVC.typeArray = self.sortDataArray;
        listVC.isSearch = YES;
        [self.navigationController  pushViewController:listVC animated:YES];
    }
    return YES;
}
-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.searchTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入搜索关键字" duration:2.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.searchTF resignFirstResponder];
}



@end

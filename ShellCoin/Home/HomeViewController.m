//
//  HomeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"
#import "HomeBannerTableViewCell.h"
#import "HomeIndustryTableViewCell.h"
#import "HomeRecommendedTableViewCell.h"
#import "HomeMerchantTableViewCell.h"
#import "CityListViewController.h"
#import "LocationManager.h"
#import "RecommentModel.h"
#import "MerchantSearchViewController.h"
#import "ForyouCollectionViewCell.h"
#import "DiscoverRootViewController.h"

@interface HomeViewController ()<UITabBarControllerDelegate,UITableViewDelegate,UITableViewDataSource,CityListViewDelegate>
@property (nonatomic, strong)NSMutableArray *privteDataSouceArray;
@property (nonatomic, strong)NSMutableArray *popularDataSouceArray;

@property (nonatomic, strong)NSMutableArray *foryouDataSouceArray;
//定位城市
@property (nonatomic, strong)NSString *locationCity;
@property (nonatomic, assign)BOOL isAlreadyRefrefsh;
@property (nonatomic, assign)NSInteger page;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tabBarController.delegate = self;
    self.locationCity = @"成都";
    
    
    
    UIColor *itemSelectTintColor = MacoColor;
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      itemSelectTintColor,
//      NSForegroundColorAttributeName,
//      [UIFont boldSystemFontOfSize:15],
//      NSFontAttributeName
//      ,nil] forState:UIControlStateSelected];
    self.tabBarController.tabBar.tintColor = itemSelectTintColor;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:itemSelectTintColor frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)]];
    [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";

    
    
    __weak HomeViewController *weak_self = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.isAlreadyRefrefsh = YES;
        //        [weak_self.tableView reloadData];
        weak_self.page = 1;
        [self getPopularMRequest];
        //        [self getActicityRequest];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer endRefreshing];
//        [self getPopularMRequest];
    }];
    //开启定位服务
    [self loadDataUseLocation];
}


#pragma mark -使用当前位置加载数据
- (BOOL)myContainsString:(NSString*)string and:(NSString *)otherString {
    NSRange range = [string rangeOfString:otherString];
    return range.length != 0;
}

-(void) loadDataUseLocation {
    [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";
    NSString *currentCity = [LocationManager sharedLocationManager].currentCity;
    __weak typeof(HomeViewController *) weak_self = self;
    if (!currentCity) {
        [[LocationManager sharedLocationManager] startLocationWithGDManager];
        [LocationManager sharedLocationManager].finishLocation = ^(NSString *city,NSString *areaName,NSError *error ,BOOL success){
            if (city) {
                if ([self myContainsString:city and:@"市"]) {
                    city =  [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
                }
                [ShellCoinUserInfo shareUserInfos].locationCity = city;
                [weak_self.locationBtn setTitle:city forState:UIControlStateNormal];
                self.locationCity = city;
                [self.tableView.mj_header beginRefreshing];
            }else{
                [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";
                [weak_self.locationBtn setTitle:@"成都" forState:UIControlStateNormal];
                [self.tableView.mj_header beginRefreshing];
            }
        };
    }else {
        [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";
        [weak_self.locationBtn setTitle:@"成都" forState:UIControlStateNormal];
        [self.tableView.mj_header beginRefreshing];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)privteDataSouceArray
{
    if (!_privteDataSouceArray) {
        _privteDataSouceArray = [NSMutableArray array];
    }
    return _privteDataSouceArray;
}

- (NSMutableArray *)popularDataSouceArray
{
    if (!_popularDataSouceArray) {
        _popularDataSouceArray = [NSMutableArray array];
    }
    return _popularDataSouceArray;
}

- (NSMutableArray *)foryouDataSouceArray
{
    if (!_foryouDataSouceArray) {
        _foryouDataSouceArray = [NSMutableArray array];
    }
    return _foryouDataSouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.privteDataSouceArray.count + 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HomeBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeBannerTableViewCell indentify]];
        if (!cell) {
            cell = [HomeBannerTableViewCell newCell];
        }
        return cell;
    }else if(indexPath.row == 1){
        HomeIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeIndustryTableViewCell indentify]];
        if (!cell) {
            cell = [HomeIndustryTableViewCell newCell];
        }
        cell.isAlreadyRefrefsh = YES;
        return cell;
    }else if(indexPath.row == 2){
        HomeRecommendedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeRecommendedTableViewCell indentify]];
        if (!cell) {
            cell = [HomeRecommendedTableViewCell newCell];
        }
        cell.jingpinArray = self.popularDataSouceArray;
        cell.foryouArray = self.foryouDataSouceArray;
        cell.recommendArray = self.privteDataSouceArray;
        return cell;
        
    }else{
        HomeMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeMerchantTableViewCell indentify]];
        if (!cell) {
            cell = [HomeMerchantTableViewCell newCell];
        }
        cell.dataModel = self.privteDataSouceArray[indexPath.row - 3];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TWitdh*(30/75.);

    }else if(indexPath.row == 1){
        CGFloat intervalX = 50.0;/**<横向间隔*/
        CGFloat intervalY = 15.0;/**<纵向间隔*/
        NSInteger columnNum = 4;/**<九宫格列数*/
        CGFloat widthAndHeightRatio = 2.0/3.0;/**<宽高比*/
        CGFloat buttonWidth = (TWitdh - 40 - intervalX * (columnNum - 1))/(CGFloat)columnNum;/**<button的宽度*/
        CGFloat buttonHeight = buttonWidth/widthAndHeightRatio;/**<button的高度*/
        return buttonHeight * 2 + intervalY*2 + 25;

    }else if(indexPath.row == 2){
        if (self.foryouDataSouceArray.count == 0&&self.popularDataSouceArray.count!=0&&self.privteDataSouceArray.count!=0) {
            return TWitdh*(36/75.) + TWitdh*(86/750.);
        }else if (self.foryouDataSouceArray.count != 0&&self.popularDataSouceArray.count==0&&self.privteDataSouceArray.count!=0){
            return TWitdh*(36/75.) + TWitdh*(86/750.);

        }else if (self.foryouDataSouceArray.count == 0&&self.popularDataSouceArray.count==0&&self.privteDataSouceArray.count!=0){
            return  TWitdh*(86/750.);
        }else if(self.foryouDataSouceArray.count == 0&&self.popularDataSouceArray.count==0&&self.privteDataSouceArray.count==0){
            return 0;
        }else if (self.foryouDataSouceArray.count != 0&&self.popularDataSouceArray.count!=0&&self.privteDataSouceArray.count==0){
            return  TWitdh*(720/750.);

        }
        return TWitdh*(72/75.) + TWitdh*(86/750.);

    }else{
        return TWitdh*(95/320.);
 
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        return;
    }
    RecommentModel *model = self.privteDataSouceArray[indexPath.row - 3];
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

#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if([viewController isMemberOfClass:[MineViewController class]]){
        if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
            //判断是否先登录
            UINavigationController *navc = [LoginViewController controller];
            [self presentViewController:navc animated:YES completion:NULL];
            return NO;
        }
    }else if ([viewController isMemberOfClass:[DiscoverRootViewController class]]){
        if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
            //判断是否先登录
            UINavigationController *navc = [LoginViewController controller];
            [self presentViewController:navc animated:YES completion:NULL];
            return NO;
        }
    }
    return YES;
}




#pragma mark - 请求人气商家，达人推荐接口
- (void)getPopularMRequest{
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude)),
                            @"city":[ShellCoinUserInfo shareUserInfos].locationCity,
                            @"pageNo":@"1",
                            @"pageSize":@"3"};
    [HttpClient GET:@"mch/highQuality" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.popularDataSouceArray removeAllObjects];
            for (NSDictionary *dic in jsonObject[@"data"][@"data"]) {
                PopularMerModel *model = [PopularMerModel modelWithDic:dic];
                [self.popularDataSouceArray addObject:model];
            }
            [self getPersonalRequest];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)getPersonalRequest{
    
    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude)),
                            @"flag":@"0"};
    [HttpClient POST:@"user/personal" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.privteDataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                [self.privteDataSouceArray addObject:[RecommentModel modelWithDic:dic]];
            }
            [self getReconnmendRequest];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 推荐商户接口
- (void)getReconnmendRequest
{
    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude)),
                            @"city":[ShellCoinUserInfo shareUserInfos].locationCity,
                            @"pageNO":@"1",
                            @"pageSize":@"3"};
    [HttpClient GET:@"mch/recommend" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (IsRequestTrue) {
            [self.foryouDataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"][@"data"];
            for (NSDictionary *dic in array) {
                [self.foryouDataSouceArray addObject:[ForYouModel modelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 选择城市
- (IBAction)locationBtn:(UIButton *)sender {
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"成都",@"重庆",@"昆明",@"德阳",@"资阳", nil];
    //历史选择城市列表
    NSMutableArray *historicalCity = [[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity];
    cityListView.arrayHistoricalCity = historicalCity;
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:self.locationCity, nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
}

#pragma mark - 搜索点击事件

- (IBAction)searchBtn:(id)sender {
    MerchantSearchViewController *searchVC = [[MerchantSearchViewController alloc]init];
    searchVC.cityName = [ShellCoinUserInfo shareUserInfos].locationCity;

    [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (void)didClickedWithCityName:(NSString*)cityName{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity]) {
        NSArray *historicalCity = [[NSUserDefaults standardUserDefaults]objectForKey:CommonlyUsedCity];
        NSMutableArray *array = [NSMutableArray arrayWithArray:historicalCity];
        if (![array containsObject:cityName]) {
            [array insertObject:cityName atIndex:0];
            if (array.count > 3) {
                [array removeLastObject];
            }
        }else{
            [array exchangeObjectAtIndex:[array indexOfObject:cityName] withObjectAtIndex:0];
        }
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:CommonlyUsedCity];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[cityName]];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:CommonlyUsedCity];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if (cityName.length > 4) {
        cityName = [cityName substringToIndex:4];
    }
    [ShellCoinUserInfo shareUserInfos].locationCity = cityName;
    [self.locationBtn setTitle:cityName forState:UIControlStateNormal];
    [self.tableView.mj_header beginRefreshing];
}
@end

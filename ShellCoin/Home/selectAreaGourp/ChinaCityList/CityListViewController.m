//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityListViewController.h"
#import "ZYPinYinSearch.h"
#import "ButtonGroupView.h"
#import "PinYinForObjc.h"
#import "LocationManager.h"
#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor lightGrayColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define HotBtnColumns 3 //每行显示的热门城市数
#define BGCOLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
@interface CityListViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate,ButtonGroupViewDelegate>
{
    UIImageView   *_bgImageView;
    UIView        *_tipsView;
    UILabel       *_tipsLab;
    NSTimer       *_timer;
}
@property (strong, nonatomic) UITextField *searchText;

@property (strong, nonatomic) NSMutableDictionary *searchResultDic;

@property (strong, nonatomic) ButtonGroupView *locatingCityGroupView;//定位城市试图

@property (strong, nonatomic) ButtonGroupView *hotCityGroupView;//热门城市

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) NSMutableArray *arrayCitys;   //城市数据

@property (strong, nonatomic) NSMutableDictionary *cities;

@property (strong, nonatomic) NSMutableArray *keys; //城市首字母


@property (nonatomic, strong)UILabel *locationCityLabel;
@end

@implementation CityListViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray array];
        
        self.arrayHistoricalCity = [NSMutableArray array];
        
        self.arrayLocatingCity   = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = MacoGrayColor;
    
    [self setNavigationWithTitle:@"选择城市"];
    [self getCityData];
    
 
    
    //3自定义背景
    
//    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40*(self.view.frame.size.height/568))];
//    searchView.backgroundColor = [UIColor clearColor];
//    
//    UIImageView *searchBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg"]];
//    searchBg.frame = CGRectMake(0, 0, searchView.frame.size.width, searchView.frame.size.height);
//    [searchView addSubview:searchBg];
//    
//    //搜索框
//    _searchText = [[UITextField alloc]initWithFrame:CGRectMake(30*(self.view.frame.size.width/320), 0, self.view.frame.size.width-30, searchView.frame.size.height)];
//    _searchText.backgroundColor = [UIColor clearColor];
//    _searchText.font = [UIFont systemFontOfSize:13];
//    _searchText.placeholder  = @"请输入城市名称或首字母查询";
//    _searchText.returnKeyType = UIReturnKeySearch;
//    _searchText.textColor    = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
//    _searchText.delegate     = self;
//    [_searchText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
//    [searchView addSubview:_searchText];
//
//    [self.view addSubview:searchView];

    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    _tableView.frame           = CGRectMake(0,searchView.frame.origin.y+searchView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.frame           = CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    [self.view addSubview:_tableView];
    
    [self ininHeaderView];
    
    //添加单击事件 取消键盘第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
}
- (void)resignFirstResponder:(UITapGestureRecognizer*)tap
{
    [_searchText resignFirstResponder];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
  
        return NO;
        
    }
    
    return YES;
    
}

- (void)textChange:(UITextField*)textField
{
    [self filterContentForSearchText:textField.text];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;  //默认的值是黑色的
    
}


- (void)setNavigationWithTitle:(NSString *)title
{
    //自定义导航栏
    title = @"";
    UIView *customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customNavView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, TWitdh, 1)];
    line.backgroundColor = MacolayerColor;
    
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TWitdh, 64)];
    bgImageView.image =[UIImage imageNamed:@"mine_bg2"];
    [customNavView addSubview:bgImageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [customNavView addSubview:backBtn];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, customNavView.frame.size.width, customNavView.frame.size.height-20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text          = title;
    [customNavView addSubview:titleLab];
    
    [self.view addSubview:customNavView];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(60, 25, self.view.frame.size.width - 80, 34)];
    searchView.backgroundColor = [UIColor whiteColor];

    UIImageView *searchBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_search_red"]];
    searchBg.frame = CGRectMake(4.5, 4.5, 25, 25);
    [searchView addSubview:searchBg];
    searchView.layer.borderColor = MacolayerColor.CGColor;
    searchView.layer.borderWidth = 1;
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 17.;
    //搜索框
    _searchText = [[UITextField alloc]initWithFrame:CGRectMake(34, 0, self.view.frame.size.width - 80 - 34, searchView.frame.size.height)];
    _searchText.backgroundColor = [UIColor whiteColor];
    _searchText.font = [UIFont systemFontOfSize:13];
    _searchText.placeholder  = @"请输入城市名称或首字母查询";
    _searchText.returnKeyType = UIReturnKeySearch;
    _searchText.textColor    = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    _searchText.delegate     = self;
    [_searchText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:_searchText];
    [customNavView addSubview:searchView];
    [customNavView addSubview:line];

}


#pragma mark -使用当前位置加载数据
- (BOOL)myContainsString:(NSString*)string and:(NSString *)otherString {
    NSRange range = [string rangeOfString:otherString];
    return range.length != 0;
}

-(void) loadDataUseLocation {
    __weak typeof(CityListViewController *) weak_self = self;
        [[LocationManager sharedLocationManager] startLocationWithGDManager];
        [LocationManager sharedLocationManager].finishLocation = ^(NSString *city,NSString *areaName,NSError *error ,BOOL success){
            if (city) {
                if ([self myContainsString:city and:@"市"]) {
                    city =  [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
                }
                [ShellCoinUserInfo shareUserInfos].locationCity = city;
                weak_self.locationCityLabel.text = city;
                [self.tableView.mj_header beginRefreshing];
            }else{
                weak_self.locationCityLabel.text = @"成都";
            }
        };
}


- (void)back:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)ininHeaderView
{
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 80)];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    //定位城市
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 2, TWitdh-20, 42)];
//    title1.text = [ NSString stringWithFormat:@"定位: %@",_arrayLocatingCity[0]];
    title1.text = [ NSString stringWithFormat:@"您所在地区"];

    title1.font = [UIFont systemFontOfSize:12];
    title1.textColor = MacoTitleColor;
    [_tableHeaderView addSubview:title1];
    
    if (!self.locationCityLabel) {
        self.locationCityLabel = [[UILabel alloc]init];
    }
    self.locationCityLabel.text = _arrayLocatingCity[0];
    self.locationCityLabel.frame = CGRectMake(15, CGRectGetMaxY(title1.frame), 80, 80 - 42 -10);
    self.locationCityLabel.layer.borderWidth = 1;
    self.locationCityLabel.layer.borderColor = MacolayerColor.CGColor;
    self.locationCityLabel.textAlignment = NSTextAlignmentCenter;
    self.locationCityLabel.textColor = MacoTitleColor;
    self.locationCityLabel.font = [UIFont systemFontOfSize:16];
    
    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWitdh, 80)];
    locationView.backgroundColor = [UIColor whiteColor];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWitdh, 1)];
    line1.backgroundColor = MacolayerColor;
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 43, TWitdh, 1)];
    line2.backgroundColor = MacolayerColor;
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 73, TWitdh, 1)];
    line3.backgroundColor = MacolayerColor;
    
    UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(TWitdh - 60, 20, 50, 50)];
    [refreshBtn setImage:[UIImage imageNamed:@"icon_replace_batch"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(loadDataUseLocation) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:refreshBtn];
    
    [locationView addSubview:line1];
//    [locationView addSubview:line2];
    [locationView addSubview:title1];
    [locationView addSubview:self.locationCityLabel];
    [_tableHeaderView addSubview:locationView];
    [_tableView addSubview:line3];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loactionAction:)];
    [locationView addGestureRecognizer:tap];
    
//    _locatingCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title1.frame.origin.y+title1.frame.size.height+10, _tableHeaderView.frame.size.width, 45)];
//    _locatingCityGroupView.delegate = self;
//    _locatingCityGroupView.columns = 3;
//    _locatingCityGroupView.items = [self GetCityDataSoucre:_arrayLocatingCity];
//    [_tableHeaderView addSubview:_locatingCityGroupView];
    
//    //常用城市
//
//    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, _locatingCityGroupView.frame.origin.y+_locatingCityGroupView.frame.size.height+10, 160, 21)];
//    title2.text = @"常用城市";
//    title2.font = [UIFont systemFontOfSize:15];
//    [_tableHeaderView addSubview:title2];
//    
//    
//    long rowHistorical = _arrayHistoricalCity.count/3;
//    if (_arrayHistoricalCity.count%3 > 0) {
//        rowHistorical += 1;
//    }
//    CGFloat hisViewHight = 45*rowHistorical;
//    _historicalCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title2.frame.origin.y+title2.frame.size.height+10, _tableHeaderView.frame.size.width, hisViewHight)];
//    _historicalCityGroupView.backgroundColor = [UIColor clearColor];
//    _historicalCityGroupView.delegate = self;
//    _historicalCityGroupView.columns = 3;
//    _historicalCityGroupView.items = [self GetCityDataSoucre:_arrayHistoricalCity];
//    [_tableHeaderView addSubview:_historicalCityGroupView];
//    
//    //热门城市
//    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(10, _historicalCityGroupView.frame.origin.y+_historicalCityGroupView.frame.size.height+10, 160, 21)];
//    title3.text = @"热门城市";
//    title3.font = [UIFont systemFontOfSize:15];
//    [_tableHeaderView addSubview:title3];
//    
//    
//    long row = _arrayHotCity.count/3;
//    if (_arrayHotCity.count%3 > 0) {
//        row += 1;
//    }
//    CGFloat hotViewHight = 45*row;
//    _hotCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title3.frame.origin.y+title3.frame.size.height+10, _tableHeaderView.frame.size.width, hotViewHight)];
//    _hotCityGroupView.backgroundColor = [UIColor clearColor];
//    _hotCityGroupView.delegate = self;
//    _hotCityGroupView.columns = 3;
//    _hotCityGroupView.items = [self GetCityDataSoucre:_arrayHotCity];
//    [_tableHeaderView addSubview:_hotCityGroupView];
//    
//    
//    _tableHeaderView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _hotCityGroupView.frame.origin.y+_hotCityGroupView.frame.size.height);
//    _tableView.tableHeaderView.frame = _tableHeaderView.frame;
    _tableView.tableHeaderView = _tableHeaderView;
}

- (void)loactionAction:(UITapGestureRecognizer *)tap
{
    if (_delegate) {
        [_delegate didClickedWithCityName:self.locationCityLabel.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (NSArray*)GetCityDataSoucre:(NSArray*)ary
{
    NSMutableArray *cityAry = [[NSMutableArray alloc]init];
    for (NSString*cityName in ary) {
        [cityAry addObject: [CityItem initWithTitleName:cityName]];
    }
    
    return cityAry;
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
//    //添加热门城市
//    NSString *strHot = @"#";
//    [self.keys insertObject:strHot atIndex:0];
//    [self.cities setObject:_arrayHotCity forKey:strHot];
    
    NSArray *allValuesAry = [self.cities allValues];
    for (NSArray*oneAry in allValuesAry) {
        
        for (NSString *cityName in oneAry) {
           [_arrayCitys addObject:cityName];
        }
    }
    
    
    

}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
    bgView.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 35)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = MacoDetailColor;
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 34, bgView.frame.size.width, 1)];
    line.backgroundColor = MacolayerColor;
    
    
    NSString *key = [_keys objectAtIndex:section];

    titleLabel.text = key;
//    [bgView addSubview:line];

    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *indexNumber = [NSMutableArray arrayWithArray:_keys];
//    NSString *strHot = @"#";
//    //添加搜索前的#号
//    [indexNumber insertObject:strHot atIndex:0];
    return indexNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    NSLog(@"title = %@",title);
    [self showTipsWithTitle:title];
    
    return index;
}

- (void)showTipsWithTitle:(NSString*)title
{
    
    //获取当前屏幕window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //添加黑色透明背景
//    if (!_bgImageView) {
//        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
//        _bgImageView.backgroundColor = [UIColor blackColor];
//        _bgImageView.alpha = 0.1;
//        [window addSubview:_bgImageView];
//    }
    if (!_tipsView) {
        //添加字母提示框
        _tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tipsView.center = window.center;
        _tipsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
        //设置提示框圆角
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.cornerRadius  = _tipsView.frame.size.width/20;
        _tipsView.layer.borderColor   = [UIColor whiteColor].CGColor;
        _tipsView.layer.borderWidth   = 2;
        [window addSubview:_tipsView];
    }
    if (!_tipsLab) {
        //添加提示字母lable
        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tipsView.frame.size.width, _tipsView.frame.size.height)];
        //设置背景为透明
        _tipsLab.backgroundColor = [UIColor clearColor];
        _tipsLab.font = [UIFont boldSystemFontOfSize:50];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        
        [_tipsView addSubview:_tipsLab];
    }
   _tipsLab.text = title;//设置当前显示字母
    
//    [self performSelector:@selector(hiddenTipsView:) withObject:nil afterDelay:0.3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hiddenTipsView];
//    });
    
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(hiddenTipsView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)hiddenTipsView
{
    [UIView animateWithDuration:0.2 animations:^{
        _bgImageView.alpha = 0;
        _tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [_tipsView removeFromSuperview];
         _bgImageView = nil;
         _tipsLab     = nil;
         _tipsView    = nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:MacoTitleColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *cityName = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    if (_delegate) {
        [_delegate didClickedWithCityName:cityName];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.;
}

-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item
{
    if (_delegate) {
       
        [_delegate didClickedWithCityName:item.cityItem.titleName];
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}




NSInteger cityNameSort(id str1, id str2, void *context)
{
    NSString *string1 = (NSString*)str1;
    NSString *string2 = (NSString*)str2;
    
    return  [string1 localizedCompare:string2];
}
/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  @param scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
    if (searchText.length > 0) {
        _searchResultDic = nil;
        _searchResultDic = [[NSMutableDictionary alloc]init];
        
        //搜索数组中是否含有关键字
        NSArray *resultAry  = [ZYPinYinSearch searchWithOriginalArray:_arrayCitys andSearchText:searchText andSearchByPropertyName:@""];
        //     NSLog(@"搜索结果:%@",resultAry) ;
        
        for (NSString*city in resultAry) {
            //获取字符串拼音首字母并转为大写
            NSString *pinYinHead = [PinYinForObjc chineseConvertToPinYinHead:city].uppercaseString;
            NSString *firstHeadPinYin = [pinYinHead substringToIndex:1]; //拿到字符串第一个字的首字母
            //        NSLog(@"pinYin = %@",firstHeadPinYin);
            
            
            NSMutableArray *cityAry = [NSMutableArray arrayWithArray:[_searchResultDic objectForKey:firstHeadPinYin]]; //取出首字母数组
            
            if (cityAry != nil) {
                
                [cityAry addObject:city];
                
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
                
            }else
            {
                cityAry= [[NSMutableArray alloc]init];
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }
            
            
            
        }
        //    NSLog(@"dic = %@",dic);

        if (resultAry.count>0) {
            _cities = nil;
            _cities = _searchResultDic;
            [_keys removeAllObjects];
            //按字母升序排列
            [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]] ;
            _tableView.tableHeaderView = nil;
            [_tableView reloadData];
        }

    }else
    {
        //当字符串清空时 回到初始状态
        _cities = nil;
         [_keys removeAllObjects];
        [_arrayCitys removeAllObjects];
        [self getCityData];
        _tableView.tableHeaderView = _tableHeaderView;
        [_tableView reloadData];
    }
    
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

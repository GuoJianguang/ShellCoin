//
//  ManagerBankCardViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManagerBankCardViewController.h"

#import "ManageBankView.h"
#import "BanCardDetailTableViewCell.h"
#import "EditBankInfoViewController.h"
#import "BankCardInfoModel.h"
#import "NoBankCardViewController.h"
#import "SCAdView.h"
#import "BankInfoCollectionViewCell.h"

@interface ManagerBankCardViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource,SCAdViewDelegate>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *dataSouceArray;

@property (nonatomic, strong) ManageBankView *manageView;

@property (nonatomic, strong)UITableView *talbeView;

@property (nonatomic, strong)SCAdView *banCardView;

@end

@implementation ManagerBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"银行卡";
    self.naviBar.delegate = self;

    self.view.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_add"];
    self.currentPage = 0;
    [self getmyBankCardRequest];
//    [self setupUI];

}

#pragma  mark - 添加银行卡
- (void)detailBtnClick
{
    if (self.dataSouceArray.count > 5  ) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您最多只能添加5张银行卡" duration:2.];
        return;
    }
    EditBankInfoViewController *editBankInfoVC = [[EditBankInfoViewController alloc]init];
    [self.navigationController pushViewController:editBankInfoVC animated:YES];
}


- (void)setupUI:(NSMutableArray *)datasoucearray {
    //模拟服务器获取到的数据
    self.banCardView = [[SCAdView alloc]initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = datasoucearray;
        builder.viewFrame = (CGRect){0,64,TWitdh,TWitdh*(310/750.)};
        builder.adItemSize = (CGSize){TWitdh/1.5f,TWitdh/1.5f*(314/576.)};
        builder.minimumLineSpacing = 8;
        builder.secondaryItemMinAlpha = 1;
        builder.threeDimensionalScale = 1.1;
        builder.allowedInfinite = NO;
        builder.itemCellNibName = @"BankInfoCollectionViewCell";
    }];
    self.banCardView.delegate = self;
    self.banCardView.backgroundColor =  [UIColor colorFromHexString:@"#faf8f6"];
    [self.view addSubview:self.banCardView];
    
    
    self.manageView.frame = CGRectMake(0, TWitdh*(290/750.) + 64, TWitdh, 78);
    self.manageView.layer.masksToBounds = YES;
    [self.view addSubview:self.manageView];
    
    self.talbeView.frame = CGRectMake(0, CGRectGetMaxY(self.manageView.frame), TWitdh, THeight - CGRectGetMaxY(self.manageView.frame));
    [self.view addSubview:self.talbeView];
    self.talbeView.delegate = self;
    self.talbeView.dataSource = self;
    self.talbeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view bringSubviewToFront:self.manageView];
    
    [self.view bringSubviewToFront:self.naviBar];

}


#pragma mark -delegate
-(void)sc_didClickAd:(id)adModel{
    
}
-(void)sc_scrollToIndex:(NSInteger)index{
    self.manageView.pageContrlVIew.currentPage = index;
    self.currentPage = index;
    [self.talbeView reloadData];
    NSLog(@"sc_scrollToIndex-->%ld",index);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
#pragma mark --懒加载

- (NSMutableArray *)dataSouceArray {
    if (_dataSouceArray == nil) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (ManageBankView *)manageView
{
    if (!_manageView) {
        _manageView = [[ManageBankView alloc]init];
    }
    return _manageView;
}


- (UITableView *)talbeView
{
    if (!_talbeView) {
        _talbeView = [[UITableView alloc]init];
    }
    return _talbeView;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanCardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BanCardDetailTableViewCell indentify]];
    if (!cell) {
        cell = [BanCardDetailTableViewCell newCell];
    }
    if (self.dataSouceArray.count > 0) {
        cell.dataModel = self.dataSouceArray[self.currentPage];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return THeight - 100;
}


#pragma mark - 获取我的银行卡
- (void)getmyBankCardRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    self.currentPage = 0;
    [HttpClient POST:@"user/withdraw/bindBankcard/get" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [self.dataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            if (array.count == 0) {
                [ShellCoinUserInfo shareUserInfos].bindingFlag = NO;
                NoBankCardViewController *noBancardVC = [[NoBankCardViewController alloc]init];
                [self.navigationController pushViewController:noBancardVC animated:YES];
                return;
            }
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[BankCardInfoModel modelWithDic:dic]];
            }
            self.manageView.pageContrlVIew.numberPages = self.dataSouceArray.count;
            self.manageView.bankModel = self.dataSouceArray[self.currentPage];
            [self setupUI:self.dataSouceArray];
//            [self.pageFlowView reloadData];
            [self.talbeView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
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

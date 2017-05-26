//
//  MallSelectShippingAddressViewController.m
//  tiantianxin
//
//  Created by ttx on 16/4/5.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "SelectShippingAddressViewController.h"
#import "AddressTableViewCell.h"
//#import "AddShippingATableViewCell.h"
//#import "EditShippingAddressViewController.h"
#import "EditAddressViewController.h"

@interface SelectShippingAddressViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)BOOL isEditShipping;

@end

@implementation SelectShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"收货地址";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_add"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.isEditShipping = NO;
    
    [self.tableView noDataSouce];
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addressRequest];
}

- (void)detailBtnClick
{
    if (self.dataSouceArray.count == 5) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您最多添加5个收货地址" duration:2.];
        return;
    }
    self.isEditShipping = !self.isEditShipping;
    EditAddressViewController *editVC = [[EditAddressViewController alloc]init];
    editVC.isAddAddress = YES;
    [self.navigationController pushViewController:editVC animated:YES];

}


- (void)addressRequest
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/userInfo/address/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"];
            [self.dataSouceArray removeAllObjects];
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[ShippingAddressModel modelWithDic:dic]];
            }
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressTableViewCell *cell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[AddressTableViewCell indentify]];
    if (!cell) {
        cell = [AddressTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];

    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh * (190/750.);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSouceArray.count) {
        return;
    }
    ShippingAddressModel *model = self.dataSouceArray[indexPath.row];
    NSDictionary *dic = @{@"model":model};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectAddress" object:nil userInfo:dic];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

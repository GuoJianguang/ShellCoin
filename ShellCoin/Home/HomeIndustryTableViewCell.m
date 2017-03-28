//
//  HomeIndustryTableViewCell.m
//  TTXForConsumer
//
//  Created by Guo on 2017/2/14.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import "HomeIndustryTableViewCell.h"
#import "SquaredUpView.h"
#import "CustomButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "MerchantListViewController.h"


@implementation NewHomeActivityModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    NewHomeActivityModel *model = [[NewHomeActivityModel alloc]init];
    model.sortId = NullToSpace(dic[@"id"]);
    model.name = NullToSpace(dic[@"name"]);
    model.icon = NullToSpace(dic[@"icon"]);
    
    model.icon = [model.icon stringByReplacingOccurrencesOfString:@"," withString:@" "];
    /*处理空格*/
    
    NSCharacterSet *characterSet2 = [NSCharacterSet whitespaceCharacterSet];
    
    // 将string1按characterSet1中的元素分割成数组
    NSArray *array2 = [model.icon componentsSeparatedByCharactersInSet:characterSet2];
    
    model.icon = array2[0];
    return model;
}


@end

@interface HomeIndustryTableViewCell()<SquaredUpViewDelegate>

@end
@implementation HomeIndustryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    // Initialization code
    
}

- (void)setIsAlreadyRefrefsh:(BOOL)isAlreadyRefrefsh
{
    _isAlreadyRefrefsh = isAlreadyRefrefsh;
    [self getGoodsTypeRequest];
}

- (void)initSquaredUpView:(NSMutableArray *)datasouceArray {
    SquaredUpView *squaredUpView = [[SquaredUpView alloc] init];
    squaredUpView.squaredUpViewDelegate = self;
    [self.contentView addSubview:squaredUpView];
    CGRect squaredeUpViewFrame = [squaredUpView layoutSquaredUpViewCellsFrameWithModelArray:datasouceArray];
    squaredUpView.frame = CGRectMake(0, 0, CGRectGetWidth(squaredeUpViewFrame), CGRectGetHeight(squaredeUpViewFrame));
    [squaredUpView.squaredUpViewCellArray enumerateObjectsUsingBlock:^(CustomButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        NewHomeActivityModel *model = datasouceArray[idx];
        [button setTitle:model.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_list_default"]];
    }];
}

- (void)jSquaredUpViewCell:(CustomButton *)cell didSelectedAtIndex:(NSInteger)index
{
    NewHomeActivityModel *model = self.sortDataSouceArray[cell.tag];
    MerchantListViewController *resultVC = [[MerchantListViewController alloc]init];
    resultVC.currentIndustry = model.name;
    resultVC.keyWord = @"";
    resultVC.currentCity = [ShellCoinUserInfo shareUserInfos].locationCity;
    [self.viewController.navigationController pushViewController:resultVC animated:YES];
}


- (NSMutableArray *)sortDataSouceArray
{
    if (!_sortDataSouceArray) {
        _sortDataSouceArray = [NSMutableArray array];
    }
    return _sortDataSouceArray;
}

//获取所有商品类型
- (void)getGoodsTypeRequest
{
    [HttpClient GET:@"mch/trades" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.sortDataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                NewHomeActivityModel *model = [NewHomeActivityModel modelWithDic:dic];
                [self.sortDataSouceArray addObject:model];
            }
            [self initSquaredUpView:self.sortDataSouceArray];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MallRootBannerCollectionViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallRootBannerCollectionViewCell.h"
#import "SquaredUpView.h"
#import "HomeIndustryTableViewCell.h"
#import "CustomButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "MerchantListViewController.h"
#import "MallGoodsListViewController.h"


@interface MallRootBannerCollectionViewCell()
@property (nonatomic, strong)NSMutableArray *sortDataSouceArray;

@end

@implementation MallRootBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
        [button sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:LoadingErrorDefaultImageCircular];
    }];
}

- (void)jSquaredUpViewCell:(CustomButton *)cell didSelectedAtIndex:(NSInteger)index
{
    MallGoodsListViewController *listVC = [[MallGoodsListViewController alloc]init];
    [self.viewController.navigationController  pushViewController:listVC animated:YES];
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



@end

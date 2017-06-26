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


@interface MallRootBannerCollectionViewCell()<SquaredUpViewDelegate>

@end

@implementation MallRootBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (void)setSortDataSouceArray:(NSMutableArray *)sortDataSouceArray
{

    _sortDataSouceArray = sortDataSouceArray;
    [self initSquaredUpView:_sortDataSouceArray];

}

- (void)initSquaredUpView:(NSMutableArray *)datasouceArray {
    for (UIView *view in self.insturdyView.subviews) {
        [view removeFromSuperview];
    }
    SquaredUpView *squaredUpView = [[SquaredUpView alloc] init];
    squaredUpView.squaredUpViewDelegate = self;
    [self.insturdyView addSubview:squaredUpView];
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
    listVC.typeId = ((NewHomeActivityModel *)self.sortDataSouceArray[cell.tag]).sortId;
    listVC.typeName = ((NewHomeActivityModel *)self.sortDataSouceArray[cell.tag]).name;
    listVC.typeArray = self.sortDataSouceArray;
    [self.viewController.navigationController  pushViewController:listVC animated:YES];
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
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}



@end

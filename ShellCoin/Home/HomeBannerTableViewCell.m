//
//  HomeTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeBannerTableViewCell.h"





@interface HomeBannerTableViewCell()<SwipeViewDelegate,SwipeViewDataSource>

@end

@implementation NewHomeModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    NewHomeModel *model = [[NewHomeModel alloc]init];
    model.bannerId = NullToSpace(dic[@"id"]);
    model.jumpWay = NullToSpace(dic[@"jumpWay"]);
    model.jumpValue = NullToSpace(dic[@"jumpValue"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.name = NullToSpace(dic[@"name"]);
    return model;
}
@end

@implementation HomeBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
    [self getBannerRequest];
}


#pragma mark - banner数据请求
- (void)getBannerRequest
{
    [ShellCoinUserInfo shareUserInfos].locationCity = @"成都市";
    NSString *searchCity = [[ShellCoinUserInfo shareUserInfos].locationCity substringToIndex:2];
    NSDictionary *parms = @{@"city":searchCity};
    [HttpClient GET:@"advert/index/list" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.bannerArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                NewHomeModel *model = [NewHomeModel modelWithDic:dic];
                model.isJump = YES;
                [self.bannerArray addObject:model];
            }
            [self.swipeView reloadData];
            [[AutoScroller shareAutoScroller]autoSwipeView:self.swipeView WithPageView:self.pageView WithDataSouceArray:self.bannerArray];
        }
        self.pageView.hidden = NO;
        self.pageView.numberPages = self.bannerArray.count;
        [self.swipeView reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.bannerArray removeAllObjects];
        NewHomeModel *model = [[NewHomeModel alloc]init];
        model.pic = @"";
        model.isJump = NO;
        [self.bannerArray addObject:model];
        self.pageView.hidden = YES;
        [self.swipeView reloadData];
        
    }];
}
- (NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

#pragma mark - banner

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.bannerArray.count;
}


- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.bounds = CGRectMake(0, 0, TWitdh, self.swipeView.bounds.size.height);
        imageView.center = swipeView.center;
        imageView.tag = 10;
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
    }else {
        imageView = (UIImageView*)[view viewWithTag:10];
    }
    NewHomeModel *model = self.bannerArray[index];
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:BannerLoadingErrorImage options:SDWebImageAllowInvalidSSLCertificates];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:LoadingErrorDefaultImageSquare];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
        }];
    return view;
}


- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    self.pageView.currentPage = swipeView.currentPage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

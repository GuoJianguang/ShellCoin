//
//  HomeRecommendedTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeRecommendedTableViewCell.h"
#import "HighQualityCollectionViewCell.h"
#import "ForyouCollectionViewCell.h"
#import "TalentRecommentViewController.h"
#import "MerchantDetailViewController.h"

@implementation PopularMerModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    PopularMerModel *model  = [[PopularMerModel alloc]init];
//    model.aviableBalance = NullToNumber(dic[@"aviableBalance"]);
    model.mchCode = NullToSpace(dic[@"code"]);
    model.mchName = NullToSpace(dic[@"name"]);
    model.pic = NullToSpace(dic[@"pic"]);
    return model;
}


@end


@interface HomeRecommendedTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation HomeRecommendedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.highqualityCollectionVIew.delegate = self;
    self.highqualityCollectionVIew.dataSource = self;
    self.foryouCollectionView.delegate = self;
    self.foryouCollectionView.dataSource = self;
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
    self.titleLabel1.textColor = self.titleLabel2.textColor =self.titleLabel3.textColor = MacoColor;
      self.titleLabel4.textColor = self.titleLabel5.textColor =self.titleLabel6.textColor = MacoDetailColor;
    [self.changeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.moreLabel.textColor = MacoColor;
    

    

}

- (void)setJingpinArray:(NSMutableArray *)jingpinArray
{
    _jingpinArray = jingpinArray;
    if (_jingpinArray.count == 0) {
        self.jingpingView.hidden = YES;
        self.jinpingHeight.constant = 0;
        return;
    }
    self.jingpingView.hidden = NO;
    self.jinpingHeight.constant = TWitdh *(36/75.);
    [self.highqualityCollectionVIew reloadData];
}


- (void)setForyouArray:(NSMutableArray *)foryouArray
{
    _foryouArray = foryouArray;
    if (_foryouArray.count == 0) {
        self.foryouView.hidden = YES;
        self.foryouHeight.constant = 0;
        return;
    }
    self.foryouView.hidden = NO;
    self.foryouHeight.constant =  TWitdh *(36/75.);
    [self.foryouCollectionView reloadData];
}

- (void)setRecommendArray:(NSMutableArray *)recommendArray
{
    _recommendArray = recommendArray;
    if (_recommendArray.count == 0) {
        self.recomendView.hidden = YES;
    }else{
        self.recomendView.hidden = NO;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.highqualityCollectionVIew) {
        return self.jingpinArray.count;
    }
    return self.foryouArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (self.foryouCollectionView == collectionView) {
        NSString *identifier =[ForyouCollectionViewCell indentify];
        static BOOL nibri =NO;
        if(!nibri)
        {
            UINib *nib = [ForyouCollectionViewCell newCell];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibri =YES;
        }
        ForyouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            cell.dataModel = self.foryouArray[indexPath.item];
        nibri=NO;
        return cell;
    }
    NSString *identifier =[HighQualityCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [HighQualityCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    HighQualityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.jingpinArray.count > 0) {
        cell.dataModel = self.jingpinArray[indexPath.item];
    }
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.foryouCollectionView) {
        
        MerchantDetailViewController *merchantDetailVC = [[MerchantDetailViewController alloc]init];
        merchantDetailVC.mchCode = ((ForYouModel *)self.foryouArray[indexPath.item]).code;
        [self.viewController.navigationController pushViewController:merchantDetailVC animated:YES];
        return;
    }
    
    MerchantDetailViewController *merchantDetailVC = [[MerchantDetailViewController alloc]init];
    merchantDetailVC.mchCode = ((PopularMerModel *)self.jingpinArray[indexPath.item]).mchCode;
    [self.viewController.navigationController pushViewController:merchantDetailVC animated:YES];
    
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.sortDataSouceArray.count < 5) {
    //        return CGSizeMake(TWitdh/self.sortDataSouceArray.count, 50);
    //    }
    return CGSizeMake((TWitdh- 24-18)/3., TWitdh * (36/75.) -  TWitdh * (86/750.));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 4.5, 0, 4.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4.5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4.5;
}


- (IBAction)talentReBtn:(id)sender {
//    TalentRecommentViewController *talentVC = [[TalentRecommentViewController alloc]init];
//    [self.viewController.navigationController pushViewController:talentVC animated:YES];
}
- (IBAction)changeBtn:(UIButton *)sender {
    [self.changeBtn setTitle:@"  正在加载" forState:UIControlStateNormal];
    [self getReconnmendRequest];
}


#pragma mark - 推荐商户接口
- (void)getReconnmendRequest
{
    //    [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";
    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude)),
                            @"city":[ShellCoinUserInfo shareUserInfos].locationCity,
                            @"pageNO":@"1",
                            @"pageSize":@"3"};
    [HttpClient GET:@"mch/recommend" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [self.changeBtn setTitle:@"  换一批" forState:UIControlStateNormal];
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [self.foryouArray removeAllObjects];
            NSArray *array = jsonObject[@"data"][@"data"];
            for (NSDictionary *dic in array) {
                [self.foryouArray addObject:[ForYouModel modelWithDic:dic]];
            }
            [self.foryouCollectionView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.changeBtn setTitle:@"  换一批" forState:UIControlStateNormal];
        [SVProgressHUD dismiss];
    }];
}

@end

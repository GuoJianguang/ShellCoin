//
//  DiscoverCollectionViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiscoverGoodsModel : BaseModel
/**
 * 商品id
 */
@property (nonatomic, copy)NSString *goodsId;
/**
 * 封面图
 */
@property (nonatomic, copy)NSString *coverImage;
/**
 * 商品名
 */
@property (nonatomic, copy)NSString *name;
/**
 * 价格
 */
@property (nonatomic, copy)NSString *price;
/**
 * 销量
 */
@property (nonatomic, copy)NSString *saleCount;

@property (nonatomic, copy)NSString *htmlUrl;

@end

@interface DiscoverCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (nonatomic, strong)DiscoverGoodsModel *dataModel;

@end

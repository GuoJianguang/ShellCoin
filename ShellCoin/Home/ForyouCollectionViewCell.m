//
//  ForyouCollectionViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ForyouCollectionViewCell.h"

@implementation ForYouModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ForYouModel *model = [[ForYouModel alloc]init];
    model.pic = NullToSpace(dic[@"pic"]);
    model.code = NullToSpace(dic[@"code"]);
    model.name = NullToSpace(dic[@"name"]);
    model.trade = NullToSpace(dic[@"trade"]);

    
    return model;
}


@end

@implementation ForyouCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.markBtn.layer.cornerRadius = 11.;
    self.markBtn.layer.masksToBounds = YES;
    self.nameLabel.textColor = MacoTitleColor;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.layer.masksToBounds = YES;
    self.markBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setDataModel:(ForYouModel *)dataModel
{
    _dataModel = dataModel;
    self.nameLabel.text = _dataModel.name;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageCircular];
    [self.markBtn setTitle:_dataModel.trade forState:UIControlStateNormal];
    
}

@end

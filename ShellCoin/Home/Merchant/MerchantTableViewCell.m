//
//  MerchantTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/27.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MerchantTableViewCell.h"

@implementation MerchantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.name_label.textColor = MacoTitleColor;
    self.detail_label.textColor = MacoDetailColor;
    self.kimter_label.textColor = MacoDetailColor;
    self.checkDetailLabe.textColor = MacoColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataModel:(MerchantModel *)dataModel
{
    _dataModel = dataModel;
    _dataModel = dataModel;
    [self.bussessImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageSquare options:SDWebImageRefreshCached];
    self.name_label.text = _dataModel.name;
    self.detail_label.text = _dataModel.desc;
    if ([_dataModel.desc isEqualToString:@""]) {
        self.detail_label.text = @"暂无商家介绍";
    }
    if ([_dataModel.recommend isEqualToString:@"1"]) {
        self.recommendImage.hidden = NO;
    }else{
        self.recommendImage.hidden = YES;
    }
    self.kimter_label.text = [NSString stringWithFormat:@"%.2f km",[self Calculationofdistance:_dataModel]];
    if ([_dataModel.distance isEqualToString:@""]) {
        self.kmiterImage.hidden = YES;
    }
    self.kimter_label.text = _dataModel.distance;

}
- (double)Calculationofdistance:(MerchantModel *)model
{
    double startlattion = [model.latitude floatValue];
    double startlongtion = [model.longitude floatValue];
    
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:startlattion  longitude:startlongtion];
    
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:[ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude longitude:[ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
    return kilometers;
}
@end

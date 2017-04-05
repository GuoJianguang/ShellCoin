//
//  ForyouCollectionViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForYouModel : BaseModel
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *trade;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *pic;

@end

@interface ForyouCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (nonatomic, strong)ForYouModel *dataModel;

@end

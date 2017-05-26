//
//  MyQrCodeTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DIiscoverQrCodeTableViewCell.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import <ZYCornerRadius/UIImageView+CornerRadius.h>
#import <UShareUI/UShareUI.h>

@implementation DIiscoverQrCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.textColor = MacoTitleColor;
    self.phoneLabel.textColor = MacoDetailColor;
    self.heardImageVIew.layer.masksToBounds = YES;
    self.heardImageVIew.layer.cornerRadius = (TWitdh-50)*(18/70.)*(122/180.)/2.;
    self.itemVIew.layer.cornerRadius = 10;
    self.itemVIew.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark -  返回按钮
- (IBAction)backBtn:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  分享功能

- (IBAction)shareBtn:(id)sender {
    
    //设置用户自定义的平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               ]];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,@"goodsId":NullToNumber(self.goodsId)};

    [HttpClient POST:@"find/recommendURL/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
            [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
            [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                [self runShareWithType:platformType withTitle:@"快分享给朋友，体验消费商带来的乐趣和收益吧。" withUrl:NullToSpace(jsonObject[@"data"])];
            }];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)runShareWithType:(UMSocialPlatformType)type withTitle:(NSString *)title withUrl:(NSString *)url
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"推荐商品" thumImage:AppIconImage];
    //设置网页地址
    shareObject.webpageUrl = url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"分享失败，请重试..." duration:2.];
        //        [self alertWithError:error];
    }];
}

- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    [self getShareRequest];
}

- (void)getShareRequest
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,@"goodsId":NullToNumber(self.goodsId)};
    [HttpClient POST:@"find/recommendURL/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [self.heardImageVIew sd_setImageWithURL:[NSURL URLWithString:[ShellCoinUserInfo shareUserInfos].avatar] placeholderImage:LoadingErrorDefaultHearder];
        self.nameLabel.text = [ShellCoinUserInfo shareUserInfos].idcardName;
        self.phoneLabel.text = [ShellCoinUserInfo shareUserInfos].phone;
        [self createQR:NullToSpace(jsonObject[@"data"])];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)createQR:(NSString *)qrUrl
{
    
    self.qrCodeImageView.image = [LBXScanWrapper createQRWithString:qrUrl size:self.qrCodeImageView.mj_size];
    CGSize logoSize=CGSizeMake(30, 30);
    UIImageView* imageView = [self roundCornerWithImage:[UIImage imageNamed:@"logo.JPG"] size:logoSize];
    //    [LBXScanWrapper addImageViewLogo:self.qrCodeImageView centerLogoImageView:imageView logoSize:logoSize];
}


- (UIImageView*)roundCornerWithImage:(UIImage*)logoImg size:(CGSize)size
{
    //logo圆角
    UIImageView *backImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    backImage.frame = CGRectMake(0, 0, size.width, size.height);
    backImage.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    logImage.image =logoImg;
    CGFloat diff  =2;
    logImage.frame = CGRectMake(diff, diff, size.width - 2 * diff, size.height - 2 * diff);
    
    [backImage addSubview:logImage];
    return backImage;
}


@end

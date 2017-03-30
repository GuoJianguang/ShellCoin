//
//  MerchantDetailViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "EnterInputMoneyView.h"

@interface MerchantDetailViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong)EnterInputMoneyView *payView;

@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviBar.hidden = YES;
    
    [self setDetail];
}

- (EnterInputMoneyView *)payView
{
    if (!_payView) {
        _payView  = [[EnterInputMoneyView alloc]init];
    }
    return _payView;
}

- (void)setDataModel:(MerchantModel *)dataModel
{
    _dataModel = dataModel;
}

- (void)setDetail{
    self.merchantNameLabel.text = _dataModel.name;
    [self.merchantImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.slidePic[0]] placeholderImage:LoadingErrorDefaultImageSquare];
    self.addressLabel.text = _dataModel.address;
    if ([_dataModel.desc isEqualToString:@""]) {
        self.detailTextView.text = @"暂无介绍";
    }else{
        self.detailTextView.text = _dataModel.desc;
    }
//    self.detailTextView.text = @"       周星驰，1962年6月22日生于香港，祖籍浙江宁波，中国香港演员、导演、编剧、制作人、商人，毕业于无线电视艺员训练班。1980年成为丽的电视台的特约演员，从而进入演艺圈。1981年出演个人首部电视剧《IQ成熟时》。1988年将演艺事业的重心转向大银幕，并于同年出演电影处女作《捕风汉子》。1990年凭借喜剧片《一本漫画闯天涯》确立其无厘头的表演风格[1]  ；同年，因其主演的喜剧动作片《赌圣》打破香港地区票房纪录而获得关注[2]  。\n1991年主演喜剧片《逃学威龙》，并再次打破香港地区票房纪录[3]  。1995年凭借喜剧爱情片《大话西游》奠定其在华语影坛的地位。1999年自导自演的喜剧片《喜剧之王》获得香港电影年度票房冠军[4]  。\n2002年凭借喜剧片《少林足球》获得第21届香港电影金像奖最佳男主角奖以及最佳导演奖[5]  。2003年成为美国《时代周刊》封面人物[6]  。2005年凭借喜剧动作片《功夫》获得第42届台湾电影金马奖最佳导演奖[7]  。2008年自导自演的科幻喜剧片《长江7号》获得香港电影年度票房冠军[8]  。2013年执导古装喜剧片《西游·降魔篇》，该片以2.18亿美元的票房成绩打破华语电影在全球的票房纪录[9-10]  。2016年担任科幻喜剧片《美人鱼》的导演、编剧、制作人，该片以超过33亿元的票房创下中国内地电影票房纪录[11-14]  。2017年1月28日，担任监制、编剧的古装喜剧片《西游伏妖篇》上映[15]  。\n演艺事业外，周星驰还涉足商界。1989年成立星炜有限公司[16]  。1996年成立星辉公司[17]  。2010年出任比高集团有限公司执行董事[18]  。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 点击事件
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)phoneBtn:(UIButton *)sender {
    sender.enabled = NO;
    [self performSelector:@selector(sendCallBtn) withObject:nil afterDelay:4.5];
    if ([self.dataModel.phone containsString:@","]) {
        NSArray *arry =   [self.dataModel.phone componentsSeparatedByString:@","];
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"拨打商家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
        for (int i = 0; i < arry.count; i ++) {
            [sheet addButtonWithTitle:arry[i]];
        }
        [sheet showInView:self.view];
        
    }else{
        //只有一个电话号码
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dataModel.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }

}

- (void)sendCallBtn{
    self.phoneBtn.enabled = YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (IBAction)collectionBtn:(id)sender {
}
- (IBAction)payBtn:(UIButton *)sender {
    
    [self.view addSubview:self.payView];
    self.payView.dataModel = self.dataModel;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

- (IBAction)addressBtn:(id)sender {
}
@end
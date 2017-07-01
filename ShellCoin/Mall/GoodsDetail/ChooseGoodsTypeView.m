//
//  ChooseGoodsTypeView.m
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ChooseGoodsTypeView.h"
#import "TypeView.h"
#import "MallSureOrderViewController.h"
#import "ShoppingCarViewController.h"
#import "CoreDataShoopingCarManagement.h"
#import "ShoopingCart+CoreDataProperties.h"

@interface ChooseGoodsTypeView()<TypeSeleteDelegete>

@property (nonatomic, strong)NSArray *sepecArray;
@property (nonatomic,strong)NSMutableDictionary *orderPrams;

#pragma mark - 加入购物车的必要数据

@property (nonatomic, assign)double cartPrice;
@property (nonatomic, copy)NSString *specDetail;
@end

@implementation ChooseGoodsTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ChooseGoodsTypeView" owner:nil options:nil][0];
        self.backView.backgroundColor = [UIColor colorFromHexString:@"#f2f2f2f2"];
        self.backView.alpha = 0.8;
        [self sendSubviewToBack:self.backView];
        self.backgroundColor = [UIColor clearColor];
        self.scrollView.bounces = YES;
        self.scrollView.pagingEnabled = NO;
        self.goodsPrice.adjustsFontSizeToFitWidth = YES;
        self.goodsPrice.textColor  = MacoColor;
        self.freight.adjustsFontSizeToFitWidth = YES;
        self.freight.textColor  = MacoColor;
        self.cartPrice = 0;
    }
    return self;
}

- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    
    [self getSqec:_goodsId];
}

- (void)setGoodsFreight:(NSString *)goodsFreight
{
    _goodsFreight = goodsFreight;
    if ([_goodsFreight doubleValue] == 0) {
        self.freight.text = [NSString stringWithFormat:@"免运费"];
        return;
    }
    self.freight.text = [NSString stringWithFormat:@"¥%.2f",[_goodsFreight doubleValue]];
}

- (NSArray *)sepecArray
{
    if (!_sepecArray) {
        _sepecArray = [NSArray array];
    }
    return _sepecArray;
}
- (NSMutableDictionary *)orderPrams
{
    if (!_orderPrams) {
        _orderPrams = [NSMutableDictionary dictionary];
    }
    return _orderPrams;
}
- (void)setGoodsModel:(MallGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.goodsNum.text = @"1";
}

#pragma mark - 获取商品规格

- (void)getSqec:(NSString *)goodsId
{
    NSDictionary *prams = @{@"id":NullToSpace(goodsId)};
    [HttpClient POST:@"shop/goodsSpec/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = [NSArray array];
            if ([jsonObject[@"data"] isKindOfClass:[NSArray class]]) {
                array = jsonObject[@"data"];
                self.sepecArray = array;
                [self addTypeView:array];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - 确定按钮
- (IBAction)sureBtn:(UIButton *)sender {
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self.viewController presentViewController:navc animated:YES completion:NULL];
        return;
    }
    
    switch (self.chooseType) {
//            加入购物车
        case ChoosType_car:
        {
            [self.orderPrams setObject:NullToNumber(self.goodsNum.text) forKey:@"quantity"];
            [self addShopCart];
        }
            break;
        case ChoosType_buy:
        {
            MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
            [self.orderPrams setObject:NullToNumber(self.goodsNum.text) forKey:@"quantity"];
            sureVC.orderArry = [NSMutableArray arrayWithArray:@[self.orderPrams]];
            [self.viewController.navigationController pushViewController:sureVC animated:YES];
            [self removeFromSuperview];
        }
            break;
        default:
            break;
    }
    

}

- (void)addTypeView:(NSArray *)guigeArray
{
    if (guigeArray.count >0) {

        CGFloat numbertop = 0;
        for (UIView *subview in self.scrollContentView.subviews) {
            if ([subview isKindOfClass:[TypeView class]]) {
                [subview removeFromSuperview];
            }
        }
        
        for (int i = 0; i < guigeArray.count; i ++) {
            TypeView *view = [[TypeView alloc]initWithFrame:CGRectMake(0, 0, TWitdh, 50) andDatasource:guigeArray[i][@"typeValue"] :guigeArray[i][@"typeName"]];
            view.sepecId = guigeArray[i][@"typeValue"][0][@"id"];
            view.typeName = guigeArray[i][@"typeName"];
            view.specVal = guigeArray[i][@"typeValue"][0][@"specVal"];

            view.tag = i + 10;
            view.delegate = self;
            [self.scrollContentView addSubview:view];
            if (i>0) {
                CGFloat viewY = CGRectGetMaxY([self.scrollContentView viewWithTag:view.tag-1].frame);
                view.frame = CGRectMake(0, viewY, TWitdh, view.height);
            }else{
                view.frame = CGRectMake(0, 0, TWitdh, view.height);

            }
            numbertop += view.height;
        }
        if (numbertop == 0) {
            return;
        }
        self.numberViewTop.constant = numbertop;
        self.scrollviewContentHeight.constant = numbertop + TWitdh*(30/75.) + 50;
//        self.scrollView.contentSize = CGSizeMake(TWitdh, numbertop + TWitdh*(20/75.) + 50);
        
    }
    
    //请求当前商品价格
    NSString *temp = [NSString string];
    self.specDetail = @"";
    for (NSDictionary *dic in guigeArray) {
        temp =  [temp stringByAppendingString:[NSString stringWithFormat:@",%@",dic[@"typeValue"][0][@"id"]]];
        self.specDetail  = [NSString stringWithFormat:@"%@%@:%@/",NullToSpace(self.specDetail),dic[@"typeName"],dic[@"typeValue"][0][@"specVal"]];
    }
    if (![self.specDetail isEqualToString:@""]) {
        self.specDetail = [self.specDetail substringToIndex:self.specDetail.length - 1];

    }
    if (![temp isEqualToString:@""]) {
        temp  = [temp substringFromIndex:1];
    }
    [self getGoodsPrice:temp];
}

- (void)btn:(UIButton *)button withIndex:(int)tag withSelf:(TypeView *)viewself
{
    for (id  btn in button.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            ((UIButton *) btn).selected = NO;
            ((UIButton *) btn).backgroundColor = [UIColor whiteColor];
            ((UIButton *) btn).layer.borderColor = MacoIntrodouceColor.CGColor;
        }
    }
    button.selected= YES;
    button.backgroundColor = MacoColor;
    button.layer.borderColor = MacoColor.CGColor;
    viewself.sepecId = self.sepecArray[viewself.tag - 10][@"typeValue"][tag][@"id"];
    viewself.specVal = self.sepecArray[viewself.tag - 10][@"typeValue"][tag][@"specVal"];
    viewself.typeName = self.sepecArray[viewself.tag - 10][@"typeName"];

    NSString *tempid = [NSString string];
    self.specDetail = @"";
    for (UIView *itemView in self.scrollContentView.subviews) {
        if ([itemView isKindOfClass:[TypeView class]]) {
            tempid =  [tempid stringByAppendingString:[NSString stringWithFormat:@",%@",((TypeView *)itemView).sepecId]];
            self.specDetail  = [NSString stringWithFormat:@"%@%@:%@/",NullToSpace(self.specDetail),((TypeView *)itemView).typeName,((TypeView *)itemView).specVal];
        }

    }
    if (![tempid isEqualToString:@""]) {
        tempid  = [tempid substringFromIndex:1];
        
    }
    if (![self.specDetail isEqualToString:@""]) {
        self.specDetail = [self.specDetail substringToIndex:self.specDetail.length - 1];
    }
    [self getGoodsPrice:tempid];

}

#pragma mark - 请求不同规格下的商品价格
- (void)getGoodsPrice:(NSString *)specStr
{
    NSDictionary *dic = @{@"id":self.goodsId,
                          @"specIds":specStr};
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/goodsPrice/get" parameters:dic success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            self.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[NullToNumber(jsonObject[@"data"][@"cashAmount"]) doubleValue] +[NullToNumber(jsonObject[@"data"][@"expectAmount"]) doubleValue]];
            self.cartPrice =[NullToNumber(jsonObject[@"data"][@"cashAmount"]) doubleValue] +[NullToNumber(jsonObject[@"data"][@"expectAmount"]) doubleValue];
            self.sureBtn.enabled = YES;
            self.goodsModel.cashAmount = NullToNumber(jsonObject[@"data"][@"cashAmount"]);
            self.goodsModel.expectAmount = NullToNumber(jsonObject[@"data"][@"expectAmount"]);
            self.goodsModel.consumeAmount = NullToNumber(jsonObject[@"data"][@"consumeAmount"]);

            [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.backgroundColor = MacoColor;
            [self.orderPrams setObject:self.goodsId forKey:@"goodsId"];
            [self.orderPrams setObject:NullToSpace(jsonObject[@"data"][@"id"]) forKey:@"priceId"];
            if (self.chooseType == ChoosType_car) {
                [self.sureBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
            }
            return ;
        }
        self.goodsPrice.text = @"";
        [self.sureBtn setTitle:NullToSpace(jsonObject[@"message"]) forState:UIControlStateNormal];
        self.sureBtn.enabled = NO;
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureBtn.backgroundColor = [UIColor grayColor];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];

    }];
}


- (IBAction)cancelBtn:(UIButton *)sender {
    [self removeFromSuperview];
}


- (IBAction)subBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];
    if (count == 1) {
        return;
    }
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",--count ];
}
- (IBAction)addBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",++count];
    
}


#pragma mark - 加入购物车

- (void)addShopCart
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@&&account=%@",self.goodsModel.goodsId,self.specDetail,[ShellCoinUserInfo shareUserInfos].userid];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects &&fetchedObjects.count > 0) {
        ((ShoopingCart *)fetchedObjects[0]).goodsNum = ((ShoopingCart *)fetchedObjects[0]).goodsNum + [self.goodsNum.text intValue];
        [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext updatedObjects];
        [[JAlertViewHelper shareAlterHelper]showTint:@"成功加入购物车" duration:2.];
        return ;
    }
    //建立一个实体描述文件
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    //通过描述文件创建一个实体
    ShoopingCart * goods = [[ShoopingCart alloc]initWithEntity: entityDescription insertIntoManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    goods.account = [ShellCoinUserInfo shareUserInfos].userid;
    goods.goodsId = self.goodsModel.goodsId;
    goods.goodsName = self.goodsModel.name;
    goods.goodsNum = (int)[self.goodsNum.text integerValue];
    goods.goodsImage = self.goodsModel.coverImage;
    goods.goodsSpec  =self.specDetail;
    goods.goodsPrice = self.cartPrice;
    goods.priceId = NullToSpace(self.orderPrams[@"priceId"]);
    goods.goodsFreight = [self.goodsModel.freight doubleValue];
    goods.cash = [self.goodsModel.cashAmount doubleValue];
    goods.coupons = [self.goodsModel.consumeAmount doubleValue];
    goods.shellCoin = [self.goodsModel.expectAmount doubleValue];
    [CoreDataShoopingCarManagement shareManageMent].isAddShopCart = YES;
    [[CoreDataShoopingCarManagement shareManageMent]saveContext];

}

@end

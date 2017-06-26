//
//  MallSearchViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallSearchViewController.h"
#import "MallSearchSortView.h"

@interface MallSearchViewController ()<MallSearchSortViewSeleteDelegete,UITextFieldDelegate>

@end

@implementation MallSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.searchTF.textColor = [UIColor whiteColor];
    [self.searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTF.delegate = self;
    [self addTypeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTypeView
{
    for (UIView *sortview in self.itemView.subviews) {
        if ([sortview isKindOfClass:[MallSearchSortView class]]) {
            [sortview removeFromSuperview];
        }
    }
    [HttpClient POST:@"shop/hotSearch/get" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *hotArray = jsonObject[@"data"];
            NSArray *guigeArray = [NSArray array];
            if (hotArray.count &&hotArray.count > 0 &&[[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]) {
                self.deleBtn.hidden = NO;
                    NSMutableArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"];
                    guigeArray = @[@{@"specList":array,@"specAttr":@"最近搜索",@"imageName":@"icon_sousuo"},
                                   @{@"specList":hotArray,@"specAttr":@"热门搜索",@"imageName":@"icon_huomiao"}
                                   ];
            }else if (hotArray.count &&hotArray.count > 0 &&![[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]){
                self.deleBtn.hidden = YES;

                guigeArray = @[
                               @{@"specList":hotArray,@"specAttr":@"热门搜索",@"imageName":@"icon_huomiao"}
                               ];
            }else if ((hotArray.count ||hotArray.count == 0) &&![[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]){
                self.deleBtn.hidden = YES;
                return ;
            }
            CGFloat numbertop = 0;
            for (int i = 0; i < guigeArray.count; i ++) {
                MallSearchSortView *view = [[MallSearchSortView alloc]initWithFrame:CGRectMake(0, 40, TWitdh, 50) andDatasource:guigeArray[i][@"specList"] :guigeArray[i][@"specAttr"] andSortImage:guigeArray[i][@"imageName"]];
                view.tag = i + 10;
                view.delegate = self;
                [self.itemView addSubview:view];
                if (i>0) {
                    CGFloat viewY = CGRectGetMaxY([self.itemView viewWithTag:view.tag-1].frame);
                    view.frame = CGRectMake(0, viewY, TWitdh, view.height);
                }
                view.bounds = CGRectMake(0, 0, TWitdh, view.height);
                numbertop += view.height;
                if (i == guigeArray.count - 1) {
                    view.isLineHidde = YES;
                }else{
                    view.isLineHidde = NO;
                    
                }
            }
            [self.itemView bringSubviewToFront:self.deleBtn];

        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.deleBtn removeFromSuperview];
    }];
    


}

- (void)btn:(UIButton *)button withIndex:(int)tag
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MallGoodsSearch" object:@{@"keyWords":button.titleLabel.text}];
    [self.view removeFromSuperview];

}


- (IBAction)cancelBtn:(UIButton *)sender {
    [self.view removeFromSuperview];
    
}
- (IBAction)deleBtn:(UIButton *)sender {
    for (UIView *sortview in self.itemView.subviews) {
        if ([sortview isKindOfClass:[MallSearchSortView class]]) {
            [sortview removeFromSuperview];
        }
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"SearchHistory"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.deleBtn.hidden  = YES;
    [HttpClient POST:@"shop/hotSearch/get" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *hotArray = jsonObject[@"data"];
            NSArray *guigeArray = [NSArray array];

            guigeArray = @[
                           @{@"specList":hotArray,@"specAttr":@"热门搜索",@"imageName":@"icon_huomiao"}
                           ];
            CGFloat numbertop = 0;
            for (int i = 0; i < guigeArray.count; i ++) {
                MallSearchSortView *view = [[MallSearchSortView alloc]initWithFrame:CGRectMake(0, 40, TWitdh, 50) andDatasource:guigeArray[i][@"specList"] :guigeArray[i][@"specAttr"] andSortImage:guigeArray[i][@"imageName"]];
                view.tag = i + 10;
                view.delegate = self;
                [self.itemView addSubview:view];
                if (i>0) {
                    CGFloat viewY = CGRectGetMaxY([self.itemView viewWithTag:view.tag-1].frame);
                    view.frame = CGRectMake(0, viewY, TWitdh, view.height);
                }
                view.bounds = CGRectMake(0, 0, TWitdh, view.height);
                numbertop += view.height;
                if (i == guigeArray.count - 1) {
                    view.isLineHidde = YES;
                }else{
                    view.isLineHidde = NO;
                    
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.deleBtn removeFromSuperview];
    }];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self valueValidated]) {
        [textField resignFirstResponder];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MallGoodsSearch" object:@{@"keyWords":textField.text}];
        NSMutableArray *array = [NSMutableArray array];
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]) {
            array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"SearchHistory"]];
        }
        if (array.count > 10) {
            [array  removeLastObject];
        }
        if (![array containsObject:textField.text]) {
            [array insertObject:textField.text atIndex:0];
        }
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"SearchHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        textField.text = @"";
        [self.view removeFromSuperview];
    }
    return YES;
}
-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.searchTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入搜索关键字" duration:2.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.searchTF resignFirstResponder];
}

@end

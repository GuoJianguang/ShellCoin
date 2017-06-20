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
    [self.searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.searchTF.delegate = self;
    [self addTypeView];
    
    [self.itemView bringSubviewToFront:self.deleBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTypeView
{
    
    NSArray *guigeArray = @[@{@"specList":@[@"羽绒服",@"毛衣外套",@"水杯",@"打底裤",@"3M防雾霾口罩"],@"specAttr":@"最近搜索",@"imageName":@"icon_sousuo"},
                            @{@"specList":@[@"羽绒服",@"毛衣外套",@"水杯",@"打底裤",@"3M防雾霾口罩",@"我的空间啊空间打开进风口看见可大可久饭卡肌肤抵抗"],@"specAttr":@"热门搜索",@"imageName":@"icon_huomiao"}
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

- (void)btn:(UIButton *)button withIndex:(int)tag
{
}


- (IBAction)cancelBtn:(UIButton *)sender {
    [self.view removeFromSuperview];
}
- (IBAction)deleBtn:(UIButton *)sender {
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self valueValidated]) {
        [textField resignFirstResponder];

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

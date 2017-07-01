//
//  CoreDataShoopingCarManagement.h
//  ShellCoin
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataShoopingCarManagement : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (CoreDataShoopingCarManagement *)shareManageMent;

@property (nonatomic, assign)BOOL isAddShopCart;

- (void)saveContext;


- (BOOL)iscanModifythedata:(NSString *)goodsId withSpec:(NSString *)specDetail withNumber:(int)num;

@end

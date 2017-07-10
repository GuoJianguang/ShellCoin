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

/**
   22  管理对象上下文
   23  */
@property (readonly, strong) NSManagedObjectContext *moc;



@end

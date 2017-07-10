//
//  CoreDataShoopingCarManagement.m
//  ShellCoin
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "CoreDataShoopingCarManagement.h"
#import "ShoopingCart+CoreDataProperties.h"

static CoreDataShoopingCarManagement *instance;


@implementation CoreDataShoopingCarManagement

#pragma mark - Core Data stack
// 如果重写了只读属性的 getter 方法，编译器不再提供 _成员变量
@synthesize moc = _moc;

+ (CoreDataShoopingCarManagement *)shareManageMent
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataShoopingCarManagement alloc]init];
    });
    return instance;
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ShoppingCar"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = instance.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        if (self.isAddShopCart) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"加入购物车失败，请重试" duration:2.];

        }
        abort();
    }
    if (self.isAddShopCart) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"成功加入购物车" duration:2.];

    }
}
/**
 19  为了低版本的兼容
 20  */
- (NSManagedObjectContext *)moc {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        return instance.persistentContainer.viewContext;
    }
    if (_moc != nil) {
         return _moc;
     }
     // 互斥锁，应该锁定的代码尽量少！
     @synchronized (self) {
         // 1. 实例化管理上下文
         _moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
         // 2. 管理对象模型（实体）
         NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
         // 3. 持久化存储调度器
         NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
         // 4. 添加数据库
         /**
          1> 数据存储类型
          3> 保存 SQLite 数据库文件的 URL
          4> 设置数据库选项
          */
         NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
         NSString *path = [cacheDir stringByAppendingPathComponent:@"ys.db"];
         // 将本地文件的完整路径转换成 文件 URL
         NSURL *url = [NSURL fileURLWithPath:path];
         NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                                   NSInferMappingModelAutomaticallyOption: @(YES)};
         [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:NULL];
         // 5. 给管理上下文指定存储调度器
         _moc.persistentStoreCoordinator = psc;
     }
    
     return _moc;
 }

@end

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


- (BOOL)iscanModifythedata:(NSString *)goodsId withSpec:(NSString *)specDetail withNumber:(int)num
{
    //查询数据
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:instance.persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@",goodsId,specDetail];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    //排序方法（这里为按照年龄升序排列）
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [instance.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        NSLog(@"数据查询错误%@",error);
//    }else{
//        if (fetchedObjects.count != 0) {
//            ((ShoopingCart *)fetchedObjects[0]).goodsNum = ((ShoopingCart *)fetchedObjects[0]).goodsNum+ num ;
//        }
//        [self saveContext];
//        return NO;
//    }

        return YES;
}

@end

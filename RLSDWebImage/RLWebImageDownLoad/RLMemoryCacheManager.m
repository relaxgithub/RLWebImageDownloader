//
//  RLMemoryCacheManager.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "RLMemoryCacheManager.h"

// 最大缓存图片个数
#define kMaxCacheCount 100

/** 内存缓存 */
/**
 为什么从一开始的继承方式变成了现在的属性方式？
 
 NSArray 和 NSDictionary 都是簇类，一般不建议写一个类去继承他们。
 如果非要重写的话,就必须要准确的重写这些基本的方法：
 insertObject:atIndex:
 removeObjectAtIndex:
 addObject:
 removeLastObject
 count
 replaceObjectAtIndex:withObject:
 
 http://blog.csdn.net/zyq527758142/article/details/40073829
 
 
 
 up vote
 24
 down vote
 accepted
 NSMutableDictionary Class Reference says:
 
 In a subclass, you must override both of its primitive methods:
 
 1. setObject:forKey:
 2. removeObjectForKey:
 
 You must also override the primitive methods of the NSDictionary class.
 
 NSDictionary Class Reference says:
 
 If you do need to subclass NSDictionary, you need to take into account that is represented by a Class cluster—there are therefore several primitive methods upon which the methods are conceptually based:
 
 1. count
 2. objectForKey:
 3. keyEnumerator
 4. initWithObjects:forKeys:count:
 
 In a subclass, you must override all these methods.
 
 NSDictionary’s other methods operate by invoking one or more of these primitives. The non-primitive methods provide convenient ways of accessing multiple entries at once.
 
 https://stackoverflow.com/questions/4789852/subclassing-nsmutabledictionary
 */

/** 缓存字典 */
static NSMutableDictionary const *memoryCache;

@implementation RLMemoryCacheManager

- (instancetype)init {
    if (self = [super init]) {
        // 监听内存警告事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    }
    
    return self;
}

+ (void)initialize {
    memoryCache = [NSMutableDictionary dictionary];
}

#pragma mark - 监听到内存警告通知，删除内存中所有图片
- (void)applicationDidReceiveMemoryWarningNotification {
    // 清空字典
    [memoryCache removeAllObjects];
    
    NSLog(@"收到了内存警告，清空内存字典!");
}

/** 根据 URL 设置缓存 */
- (void)setImage:(UIImage *)image ForKey:(NSString *)key {
    if ([memoryCache.allKeys containsObject:key]) {
        // 取消重复缓存;
        return;
    }
    [memoryCache setObject:image forKey:key];
    if (memoryCache.allKeys.count > kMaxCacheCount) {
        [memoryCache removeObjectForKey:memoryCache.allKeys.firstObject];
    }
    
    NSLog(@"%@",@"图片进了内存缓存!");
}

/** 根据 URL 取得缓存图片 */
- (UIImage *)imageForKey:(NSString *)key; {
   // NSAssert(key && getCacheImageBlock, @"参数错误!");
    return [memoryCache objectForKey:key];
}


@end

//
//  RLCacheManager.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "RLCacheManager.h"

#import "RLDiskCacheManager.h"
#import "RLMemoryCacheManager.h"

@interface RLCacheManager ()
/** 磁盘缓存 */
@property (nonatomic,strong) RLDiskCacheManager *diskCache;

/** 内存缓存 */
@property (nonatomic,strong) RLMemoryCacheManager *memoryCache;

@end

@implementation RLCacheManager

- (instancetype)init {
    if (self = [super init]) {
        self.diskCache = [[RLDiskCacheManager alloc] init];
        self.memoryCache = [[RLMemoryCacheManager alloc] init];
    }
    
    return self;
}

/** 根据下载链接查询图片文件 */
- (void)imageForKey:(NSString *)key findImageBlock:(void(^)(UIImage *))findimageBlock {
    NSAssert(key && findimageBlock, @"参数错误!");
    // 1. 先从内存缓存中找
    UIImage *image = [self.memoryCache imageForKey:key];
    if (image) { findimageBlock(image); return; }
    
    // 2. 从沙盒中找
    [self.diskCache imageForKey:key complectionBlock:^(UIImage *image) {
        findimageBlock(image);
        // 帮当前图片存放在内存缓存中
        if (image) {
            [self.memoryCache setImage:image ForKey:key];
        }
    }];
}

/** 保存文件到内存和磁盘 */
- (void)saveImage:(UIImage *)image urlString:(NSString *)urlString {
    [self.memoryCache setImage:image ForKey:urlString];
    [self.diskCache saveImage:image url:urlString];
}

@end

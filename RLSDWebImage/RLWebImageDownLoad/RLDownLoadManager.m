//
//  RLDownLoadManager.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "RLDownLoadManager.h"

/** 最大下载并发数 */
#define kMaxConcurrentOperationCount 5

@interface RLDownLoadManager ()
///** 内存缓存管理 */
//@property (nonatomic,strong) RLMemoryCacheManager *memoryCacheManager;
///** 磁盘缓存管理 */
//@property (nonatomic,strong) RLDiskCacheManager *diskCacheManager;

@property (nonatomic,strong) RLCacheManager *cacheManager;

/** 下载任务队列管理 */
@property (nonatomic,strong) NSOperationQueue *queue;

/** 网络下载器 */
@property (nonatomic,strong) NSURLSession *session;


/** 当前正在下载的任务队列 */
@property (nonatomic,strong) NSMutableArray<RLImageDownLoadOperation *> *downloadingOperations;


@end

@implementation RLDownLoadManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static RLDownLoadManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RLDownLoadManager alloc] init];
        /** 内存管理 */
        instance.cacheManager = [[RLCacheManager alloc] init];
        /** 磁盘管理 */
        // instance.diskCacheManager = [[RLDiskCacheManager alloc] init];
        /** 下载任务队列 */
        instance.queue = [[NSOperationQueue alloc] init];
        instance.queue.maxConcurrentOperationCount = kMaxConcurrentOperationCount;
        /** 下载管理器 */
        instance.session = [NSURLSession sharedSession];
        
        /** 当前正在下载的任务 */
        instance.downloadingOperations = [NSMutableArray array];
    });
    
    return instance;
}

/** 检查当前下载链接是否正在下载中 */
- (BOOL)isDownLoadingWithURLString:(NSString *)urlString {
    if (self.downloadingOperations.count == 0) {
        return NO;
    }
    
    __block BOOL isLoading = NO;
    
    [self.downloadingOperations enumerateObjectsUsingBlock:^(RLImageDownLoadOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.urlString isEqualToString:urlString]) {
            *stop = YES;
            isLoading = YES;
        }
    }];
    
    return isLoading;
}

- (void)downLoadImageWithURLString:(NSString *)urlString complectionBlock:(void(^)(UIImage *,NSError *))complectionBlock {
    NSAssert(urlString && complectionBlock, @"参数错误!");
    // 0.检查当前任务是否正在下载中
    BOOL isDownloading = [self isDownLoadingWithURLString:urlString];
    if (isDownloading) {NSLog(@"图片正在下载中...不要重复下载!"); return; }
    
    
    // 1. 首先根据 urlString 去缓存中找
    [self.cacheManager imageForKey:urlString findImageBlock:^(UIImage *image) {
        
        // 如果找到了，直接 return
        if (image) {
            NSLog(@"图片来自缓存!!!!");
            complectionBlock(image,nil);
            return;
        }
        
        // 创建一个下载任务。
       __block RLImageDownLoadOperation *downloadOP = [RLImageDownLoadOperation downloadWithURLString:urlString complectionBlock:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
                return ;
            }
           
           dispatch_async(dispatch_get_main_queue(), ^{
               // 将图片回调到外界
               complectionBlock(image,nil);
           });
           
           
            // 本地缓存图片
            [self.cacheManager saveImage:image urlString:urlString];
            
            // 将下载任务从队列中移除
            [self.downloadingOperations removeObject:downloadOP];
        }];
        
        // 甚至可以取消一个队列中的任务。
        // [downloadOP cancel];
        
        
        
        // 添加当前下载任务
        [self.downloadingOperations addObject:downloadOP];
        // 将当前操作添加到队列
        [self.queue addOperation:downloadOP];
        
        // 根据下载路径生成 NSURL
//        NSURL *URL = [NSURL URLWithString:urlString];
//        NSURLSessionTask * task = [self.session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (error) {
//                complectionBlock(nil,error);
//                return ;
//            }
//            UIImage *imageData = [UIImage imageWithData:data];
//            // 将图片返回回去
//            dispatch_async(dispatch_get_main_queue(), ^{
//                complectionBlock(imageData,nil);
//            });
//            
//            // 缓存图片数据
//            [self.cacheManager saveImage:imageData urlString:urlString];
//        }];
        
    }];
}

- (void)cancelAllDownLoading {
    /** 取消队列中，所有的操作。。但是已经执行的操作无法挂起 */
    self.queue.suspended = YES;
}

/** recover 所有下载任务 */
- (void)recoverAllDownLoadOperations {
    self.queue.suspended = NO;
}


@end

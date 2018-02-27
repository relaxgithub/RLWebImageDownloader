//
//  RLDownLoadManager.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLCacheManager.h" // 缓存管理器
#import "RLImageDownLoadOperation.h" // 下载操作。


@interface RLDownLoadManager : NSObject

+ (instancetype)sharedManager;

/** 下载图片 */
- (void)downLoadImageWithURLString:(NSString *)urlString complectionBlock:(void(^)(UIImage *,NSError *))complectionBlock;

/** 取消所有的任务下载 */
- (void)cancelAllDownLoading;

/** recover 所有下载任务 */
- (void)recoverAllDownLoadOperations;
@end

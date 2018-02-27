//
//  RLCacheManager.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface RLCacheManager : NSObject

/** 根据下载链接查询图片文件 */
- (void)imageForKey:(NSString *)key findImageBlock:(void(^)(UIImage *))findimageBlock;

/** 保存文件到内存和磁盘 */
- (void)saveImage:(UIImage *)image urlString:(NSString *)urlString;

@end

//
//  RLDiskCacheManager.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLDiskCacheManager : NSObject

/** 根据图片下载链接，在沙盒中找到此文件 */
- (void)imageForKey:(NSString *)key complectionBlock:(void(^)(UIImage *))complectionBlock;

/** 保存图片到沙盒 */
- (void)saveImage:(UIImage *)image url:(NSString *)url;

@end

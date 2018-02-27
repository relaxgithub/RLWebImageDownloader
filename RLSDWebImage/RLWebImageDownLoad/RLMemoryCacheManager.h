//
//  RLMemoryCacheManager.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLMemoryCacheManager : NSObject

/** 根据 URL 设置缓存 */
- (void)setImage:(UIImage *)image ForKey:(NSString *)key;

/** 根据 URL 去的缓存图片 */
- (UIImage *)imageForKey:(NSString *)key;

@end

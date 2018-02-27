//
//  RLImageDownLoadOperation.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RLImageDownLoadOperation : NSOperation


@property (nonatomic,strong) NSString *urlString;



/// 下载任务是由一个 URL 字符串开始的。
+ (instancetype)downloadWithURLString:(NSString *)urlString complectionBlock:(void(^)(UIImage *,NSError *))complectionBlock;

@end

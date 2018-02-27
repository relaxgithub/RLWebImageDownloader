//
//  RLImageDownLoadOperation.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "RLImageDownLoadOperation.h"

@interface RLImageDownLoadOperation ()

@property (nonatomic,strong) NSURL *URL;

// 图片下载完成回调
@property (nonatomic,copy) void(^downloadcomplectionBlock)(UIImage *,NSError *);


@end

@implementation RLImageDownLoadOperation

+ (instancetype)downloadWithURLString:(NSString *)urlString complectionBlock:(void (^)(UIImage *,NSError *))complectionBlock{
    RLImageDownLoadOperation * obj = [self new];
    obj.URL = [NSURL URLWithString:urlString];
    obj.downloadcomplectionBlock = complectionBlock;
    obj.urlString = urlString;
    
    NSAssert(obj.downloadcomplectionBlock, @"下载完成 block 不能为空!");
    
    return obj;
}

// 重写 main 方法，开启下载任务 dataTask
- (void)main {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        error ? self.downloadcomplectionBlock(nil, error) : self.downloadcomplectionBlock([UIImage imageWithData:data],nil);
    }];
    
    [task resume];
}

@end

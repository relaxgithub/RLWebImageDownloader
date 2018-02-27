//
//  UIImageView+RLImageView.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "UIImageView+RLImageView.h"
#import "RLDownLoadManager.h"

@implementation UIImageView (RLImageView)

- (void)rl_setImageWithURLString:(NSString *)urlString placeHolder:(NSString *)imageName {
    // 1.首先设置占位图
    self.image = [UIImage imageNamed:imageName];
    
    // 2.下载网络图片
    [[RLDownLoadManager sharedManager] downLoadImageWithURLString:urlString complectionBlock:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        
        self.image = image;
    }];
}

@end

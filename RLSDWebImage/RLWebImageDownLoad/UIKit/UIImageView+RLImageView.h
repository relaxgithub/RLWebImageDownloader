//
//  UIImageView+RLImageView.h
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RLImageView)


/**
 将图片设置到 UIImageView 里面

 @param urlString 下载链接
 @param imageName  placeholder 占位图
 */
- (void)rl_setImageWithURLString:(NSString *)urlString placeHolder:(NSString *)imageName;

@end

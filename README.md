# RLWebImageDownloader
 一款用于下载图片的简单的框架。
简单的使用方式：
1. 导入头文件
  #import "RLDownLoadManager.h"
  
2. 使用 
 ```Objective-C
 
    [[RLDownLoadManager sharedManager] downLoadImageWithURLString:_downloadStrings[downloadIndex] complectionBlock:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        } 
        self.imageView.image = image;
        // downloadIndex++;
    }];
 ```

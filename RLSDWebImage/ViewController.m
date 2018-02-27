//
//  ViewController.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "ViewController.h"
#import "RLDownLoadManager.h" // 导入框架头文件

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

static NSUInteger downloadIndex = 0;

@implementation ViewController {
    // 下载中的任务列表
    // NSMutableArray<NSOperation *> *_downloadingOperations;
    // 图片内存缓存
    // NSMutableDictionary<NSURL *,UIImage *> *_imageCache;
    
    NSArray<NSString *> *_downloadStrings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化内存字典
    // _imageCache = [NSMutableDictionary dictionary];
    
    // 下载网络图片
    // [self downLoadImage];
    
    _downloadStrings = @[
                         @"http://pic.tesetu.com/2017/0426/30/10.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/11.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/12.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/13.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/14.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/15.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/16.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/17.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/18.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/19.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/20.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/21.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/22.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/23.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/24.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/25.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/26.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/27.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/28.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/30.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/31.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/32.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/33.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/34.jpg",
                         @"http://pic.tesetu.com/2017/0426/30/35.jpg"
                         ];
    
}

#pragma mark - 使用刚写的框架来下载图片，并设置缓存

- (IBAction)demoDownLoad:(id)sender {
    
    if (downloadIndex == _downloadStrings.count) {
        NSLog(@"%@",@"数组内图片下载完毕!");
        return;
    }
    
        
    
    
    [[RLDownLoadManager sharedManager] downLoadImageWithURLString:_downloadStrings[downloadIndex] complectionBlock:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        
        self.imageView.image = image;
        // downloadIndex++;
    }];
}

- (IBAction)downLoadImageFromNet:(id)sender {
    // [self downLoadImage];
}

//#pragma mark - 删除内存缓存
//- (IBAction)deleteMemoryCache:(id)sender {
//    [_imageCache removeAllObjects];
//}



#pragma mark - 首先是普通的使用 NSURLSession 下载图片
//- (void)downLoadImage {
//    NSString *urlString = @"http://pic.tesetu.com/2017/0426/30/12.jpg";
//    NSURL *URL = [NSURL URLWithString:urlString];
//    // 先从本地缓存里取.
//    UIImage *image = [_imageCache valueForKey:urlString];
//    // 对 URLString 进行 hash。
//    NSUInteger code = [urlString hash];
//    NSString *saveName = [[@(code) stringValue] stringByAppendingString:urlString.lastPathComponent];
//    // NSLog(@"%@",saveName);
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:saveName];
//    if (image) {
//        NSLog(@"从内存缓存中，获取图片");
//        self.imageView.image = image;
//        return;
//    } else {
//        // 从沙盒中取
//        // 为了不阻塞主线程，才用异步的方式。
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            // 获取 URL 的 hash 值。
//            NSString *fileName = [@(urlString.hash).description stringByAppendingString:urlString.lastPathComponent];
//            NSString *pPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
//            
//           //  NSData *data = [[NSData alloc] initWithContentsOfFile:pPath];
////            NSData *data = [NSData:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:pPath]];
//            UIImage *imageFromCache = [[UIImage alloc] initWithContentsOfFile:pPath];
//            if (imageFromCache) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"图片来自沙盒缓存！");
//                    self.imageView.image = imageFromCache;
//                });
//            } else {
//                // 从网络异步加载图片
//                // 图片需要异步下载。
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                        UIImage *image = [[UIImage alloc] initWithData:data];
//                        // 图片下载完毕之后，缓存在本地缓存里。
//                        [_imageCache setObject:image forKey:urlString];
//                        // 并且存储到沙盒路径
//                        // 将图片异步写入磁盘
//                        // 1. 获取文件的二进制数据
//                        NSData *imageData = UIImagePNGRepresentation(image);
//                        // 2. 将二进制数据写入磁盘
//                        BOOL result = [imageData writeToFile:path atomically:YES];
//                        
//                        result ? NSLog(@"%@",path) : NSLog(@"%@",@"存储失败!");
//                        
//                        // 回到主线程，加载图片
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSLog(@"图片是从网络获取过来的!");
//                            self.imageView.image = image;
//                        });
//                    }] resume];
//                });
//                
//            }
//            
//            
//        });
//    }
//    
//    // return;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

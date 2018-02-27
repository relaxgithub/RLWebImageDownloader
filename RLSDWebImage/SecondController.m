//
//  SecondController.m
//  RLSDWebImage
//
//  Created by relax on 2017/11/20.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "SecondController.h"
#import "UIImageView+RLImageView.h"

@interface SecondController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageView rl_setImageWithURLString:@"http://pic.tesetu.com/2017/0426/30/21.jpg" placeHolder:@"placeholder.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

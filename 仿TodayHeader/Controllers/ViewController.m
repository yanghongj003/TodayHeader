//
//  ViewController.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetUp];
}

- (void)initSetUp{
    // 添加contentView
    ContentViewController *content = [self.storyboard instantiateViewControllerWithIdentifier:@"Content"];
    [self addChildViewController:content];
    [self.view addSubview:content.view];
}
@end

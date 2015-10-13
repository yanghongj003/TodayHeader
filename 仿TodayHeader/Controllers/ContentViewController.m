//
//  ContentViewController.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "ContentViewController.h"
#import "HeaderScrollView.h"
#import "ContentScrollView.h"
#import "RecommendedViewController.h"
#import "XianViewController.h"
#import "HotViewController.h"
#import "SocialViewController.h"
#import "EntertainmentViewController.h"
#import "ScienceViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetUp];
}

- (void)initSetUp{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    // 1:添加头部滚动View
    
    HeaderScrollView *headerScroll = [[HeaderScrollView alloc] init];
    headerScroll.frame = CGRectMake(0, 64, size.width, 40);
    headerScroll.titles = @[@"推荐",@"西安",@"热点",@"社会",@"娱乐",@"科技"];
    [self.view addSubview:headerScroll];
    
   // 2:添加内容滚动View
    
    ContentScrollView *contentScroll = [[ContentScrollView alloc] init];
    contentScroll.frame = CGRectMake(0, 104, size.width, size.height-104);
    
    RecommendedViewController *recomend = [[RecommendedViewController alloc] init];
    recomend.contents = @[@"111",@"111",@"111",@"111",@"111",@"111",@"111",@"111"];
    
    XianViewController *xian = [[XianViewController alloc] init];
    xian.contents = @[@"222",@"222",@"222",@"222",@"222",@"222",@"222",@"222",@"222"];
    
    HotViewController *hot = [[HotViewController alloc] init];
    hot.contents = @[@"333",@"333",@"333",@"333",@"333",@"333",@"333",@"333",@"333"];
    
    SocialViewController *social = [[SocialViewController alloc]init];
    social.contents = @[@"444",@"444",@"444",@"444",@"444",@"444",@"444",@"444"];
    
    EntertainmentViewController *enter = [[EntertainmentViewController alloc] init];
    enter.contents = @[@"555",@"555",@"555",@"555",@"555",@"555",@"555",@"555"];
    
    ScienceViewController *scien = [[ScienceViewController alloc] init];
    scien.contents = @[@"666",@"666",@"666",@"666",@"666",@"666",@"666",@"666"];
    
    contentScroll.contentViews = @[recomend,xian,hot,social,enter,scien];
    [self.view addSubview:contentScroll];
    
}

@end

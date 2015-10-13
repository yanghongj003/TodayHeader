//
//  RecommendedViewController.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "RecommendedViewController.h"

@interface RecommendedViewController ()

@end

@implementation RecommendedViewController

@synthesize contents=_contents;

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    [self.tableView reloadData];
}
@end

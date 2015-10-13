//
//  HotViewController.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

@synthesize contents=_contents;

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    [self.tableView reloadData];
}

@end

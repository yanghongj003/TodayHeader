//
//  ScienceViewController.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "ScienceViewController.h"

@interface ScienceViewController ()

@end
@implementation ScienceViewController

@synthesize contents=_contents;

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    [self.tableView reloadData];
}
@end

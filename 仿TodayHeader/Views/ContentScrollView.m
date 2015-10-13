//
//  ContentScrollView.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//

#import "ContentScrollView.h"
@interface ContentScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scroll;
@end
@implementation ContentScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        // 1:添加滚动view
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.pagingEnabled = YES;
        scroll.delegate = self;
        [self addSubview:scroll];
        self.scroll = scroll;
        
        // 2:注册通知
        [[NSNotificationCenter defaultCenter] addObserverForName:@"moveContentView" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSInteger btnTag = [note.userInfo[@"index"]integerValue];
            [self.scroll setContentOffset:CGPointMake(btnTag*size.width, 0) animated:YES];
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.scroll.frame = self.bounds;
    self.scroll.contentSize = CGSizeMake(self.contentViews.count*size.width, 0);
    for (int j = 0; j<self.scroll.subviews.count; j++) {
        UIView *subView = self.scroll.subviews[j];
        subView.tag = j;
        subView.frame = CGRectMake(j*size.width, 0, self.bounds.size.width, self.bounds.size.height);
    }
}
// 重写set方法
- (void)setContentViews:(NSArray *)contentViews
{
    _contentViews = contentViews;
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int j = 0; j<_contentViews.count; j++) {
        UIViewController *vc = _contentViews[j];
        [self.scroll addSubview:vc.view];
    }
    [self layoutIfNeeded];
}

#pragma mark -scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveRedView" object:nil userInfo:@{@"index":@(scrollView.contentOffset.x/size.width)}];
}

@end

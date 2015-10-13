//
//  HeaderScrollView.m
//  仿TodayHeader
//
//  Created by hsbc on 15/7/15.
//  Copyright (c) 2015年 Zp. All rights reserved.
//
#import "HeaderScrollView.h"
#define kmargin 10
@interface HeaderScrollView()

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,weak) UIButton *selectBtn;

@end

@implementation HeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1:添加滚动view
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.backgroundColor = [UIColor lightGrayColor];
        scroll.contentInset = UIEdgeInsetsZero;
        [self addSubview:scroll];
        self.scroll = scroll;
        
        // 2:添加一个红色的View
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = [UIColor redColor];
        redView.layer.cornerRadius = 5;
        redView.opaque = YES;
        [self.scroll addSubview:redView];
        self.redView = redView;
        
        // 3:注册通知
        [[NSNotificationCenter defaultCenter] addObserverForName:@"moveRedView" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
             NSInteger index = [[note.userInfo objectForKey:@"index"]integerValue];
            [self btnClick:self.btns[index]];
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scroll.frame = self.bounds;
    self.scroll.contentSize = CGSizeMake(self.titles.count*70, 0);
    for (int j = 0; j<self.btns.count; j++) {
        UIButton *btn = self.btns[j];
        btn.frame = CGRectMake(kmargin+j*(60+kmargin), 0, 60, self.bounds.size.height);
        if (j==0) {
            self.selectBtn = btn;
            [self btnClick:btn];
        }
    }
    self.redView.frame = CGRectMake(2*kmargin, kmargin, 40, 20);
}
// 重写set方法
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    // 1:移除所有的按钮
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btns = [NSMutableArray array];
    
    // 2:重写添加按钮
    for (int j = 0; j<_titles.count; j++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = j;
        [btn setTitle:self.titles[j] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.scroll addSubview:btn];
        [self.btns addObject:btn];
    }
    [self layoutIfNeeded];
}
// 监听按钮点击
- (void)btnClick:(UIButton*)btn
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    // 1:发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveContentView" object:nil userInfo:@{@"index":@(btn.tag)}];
    // 2:先前选中的按钮设置字体颜色成黑色
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 3:x方向需要移动的距离
    CGFloat tranX = (btn.tag - self.selectBtn.tag)*70;
    [UIView animateWithDuration:0.3 animations:^{
        // 1:设置红色View的frame
        CGRect frame = self.redView.frame;
        frame.origin.x += tranX;
        self.redView.frame = frame;
        BOOL isMoveRight = (CGRectGetMaxX(self.redView.frame)-self.scroll.contentOffset.x)>=size.width;
        if (isMoveRight) {
           [self.scroll setContentOffset:CGPointMake(tranX+self.scroll.contentOffset.x, 0) animated:YES];
        } else if(self.scroll.contentOffset.x>0){
            [self.scroll setContentOffset:CGPointMake(tranX+self.scroll.contentOffset.x, 0) animated:YES];
        } else {
        
            [self.scroll setContentOffset:CGPointZero animated:YES];
        }
    } completion:^(BOOL finished) {
       [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.selectBtn = btn;
    }];
}

@end

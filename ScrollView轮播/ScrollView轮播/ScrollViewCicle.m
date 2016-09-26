//
//  ScrollViewCicle.m
//  ScrollView轮播
//
//  Created by ma c on 15/9/10.
//  Copyright (c) 2015年 huhong. All rights reserved.
//

#import "ScrollViewCicle.h"
#define HHWIDTH self.frame.size.width
#define HHHEIGHT self.frame.size.height
#define COUNT self.imageArray.count

@interface ScrollViewCicle()<UIScrollViewDelegate>

@property (strong,nonatomic) NSArray* imageArray;
@property (assign,nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ScrollViewCicle{
    UIImageView*  _leftImageView;
    UIImageView* _centerImageView;
    UIImageView* _rightImageView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControl = [[UIPageControl alloc] init];
        // 总页数
        _pageControl.numberOfPages = self.imageArray.count;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:self.imageArray.count];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x, 130);
        
        // 设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        [self addSubview:_pageControl];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (void)startTimer
{

    __weak __typeof(&*self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    NSUInteger count = self.imageArray.count;
    NSInteger page = (self.pageControl.currentPage + 1) % count;
    self.pageControl.currentPage = page;
    
    // 调用监听方法，让滚动视图滚动
    _currentIndex = (_currentIndex + 1) % COUNT;
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(HHWIDTH*2, 0);
    } completion:^(BOOL finished) {
        [self.scrollView setContentOffset:CGPointMake(HHWIDTH, 0) animated:NO];
        [self reloadImage:self.currentIndex];
    }];
}
- (void)ciclePicture:(NSArray *)imageArray andFrame:(CGRect)frame andCurrentImage:(NSInteger)currentImageIndex{
    self.frame = frame;
    self.imageArray = imageArray;
    self.currentIndex = currentImageIndex;
    [self createUI];
    
    [self reloadImage:self.currentIndex];

}

- (void)createUI{
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.tag = 100;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(HHWIDTH*3, 0);
    scrollView.contentOffset = CGPointMake(HHWIDTH, 0);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HHWIDTH, HHHEIGHT)];
    [scrollView addSubview:_leftImageView];
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HHWIDTH, 0, HHWIDTH, HHHEIGHT)];
    [scrollView addSubview:_centerImageView];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HHWIDTH*2, 0, HHWIDTH, HHHEIGHT)];
    [scrollView addSubview:_rightImageView];
    self.scrollView = scrollView;
    self.pageControl.currentPage = 0;

    [self startTimer];
}

//设置imageView的图片
- (void)reloadImage:(NSInteger)currentIndex {
    _leftImageView.image = [UIImage imageNamed:self.imageArray[(currentIndex - 1 + COUNT) % COUNT]];
    _centerImageView.image = [UIImage imageNamed:self.imageArray[currentIndex]];
    _rightImageView.image = [UIImage imageNamed:self.imageArray[(currentIndex + 1) % COUNT]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > HHWIDTH) {//向左滑动
        _currentIndex = (_currentIndex + 1) % COUNT;
    }else if (scrollView.contentOffset.x < HHWIDTH) {//向右滑动
        _currentIndex = (_currentIndex - 1 + COUNT) % COUNT;
    }

    [self reloadImage:_currentIndex];
    [self.pageControl setCurrentPage:_currentIndex];
    [scrollView setContentOffset:CGPointMake(HHWIDTH, 0) animated:NO];

}
/**
 修改时钟所在的运行循环的模式后，抓不住图片
 
 解决方法：抓住图片时，停止时钟，送售后，开启时钟
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止时钟，停止之后就不能再使用，如果要启用时钟，需要重新实例化
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s", __func__);
    [self startTimer];
}



@end

//
//  BannerView.m
//  首页首行左右滚动视图
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"BannerView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *containerView = [[[UINib nibWithNibName:@"BannerView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
#pragma mark - 初始化scrollView上的视图
-(void)loadBannerImage:(NSArray*)dataArray
{
    NSInteger imageCount = dataArray.count;
    int scrollAnchor = -kWidth;
    for (int i =0; i < imageCount; i++) {
        scrollAnchor += kWidth;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollAnchor, 0, kWidth, self.frame.size.height)];
        
        imageView.image = [UIImage imageNamed:dataArray[i]];
        imageView.clipsToBounds = NO;
        imageView.backgroundColor = [UIColor redColor];
        imageView.tag = i;
        [bannerScrollView addSubview:imageView];
    }
    bannerScrollView.contentSize = CGSizeMake(scrollAnchor+kWidth, self.frame.size.height);
    
    spacePageControl.numberOfPages = dataArray.count;
    [spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"homepage_banner_select"]];
    [spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"homepage_banner_selected_highted"]];
    spacePageControl.currentPage = 0;
    [spacePageControl addTarget:self action:@selector(spacePageControl:) forControlEvents:UIControlEventValueChanged];
    
    //点击bannerImage的触发事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImageInScrollView:)];
    [bannerScrollView addGestureRecognizer:tap];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    float wid ;
    wid = _scrollView.contentOffset.x;
    spacePageControl.currentPage = round(wid/kWidth);
    
}
#pragma mark - 点击bannerView的触发事件
-(void)touchImageInScrollView:(UITapGestureRecognizer*)sender
{
    CGPoint point = [sender locationInView:bannerScrollView];
    float pointX = point.x;
    int pageIndex = pointX/kWidth;
    NSLog(@"touchImageInScrollView pageIndex == %d",pageIndex);
}
- (void)spacePageControl:(SMPageControl *)sender
{
    NSLog(@"Current Page (SMPageControl): %li", (long)sender.currentPage);
    CGPoint offset = CGPointMake(bannerScrollView.frame.size.width * sender.currentPage, 0);
    [bannerScrollView setContentOffset:offset animated:YES];
}
@end

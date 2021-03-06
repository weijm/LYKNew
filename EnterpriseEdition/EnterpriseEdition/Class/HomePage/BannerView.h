//
//  BannerView.h
//  首页首行左右滚动视图
//
//  Created by wjm on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"

@interface BannerView : UIView<UIScrollViewDelegate>
{
    
    __weak IBOutlet UIScrollView *bannerScrollView;
   
    
    __weak IBOutlet SMPageControl *spacePageControl;
    
    NSTimer *shuffTimer;
    
    NSInteger imageCount;
   
}
@property(nonatomic,copy) void(^clickedBannerAction)(int index);
/**
 初始化scrollView上的视图
 */
-(void)loadBannerImage:(NSArray*)dataArray;
@end

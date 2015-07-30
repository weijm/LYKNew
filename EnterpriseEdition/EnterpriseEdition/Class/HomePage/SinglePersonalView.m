//
//  SinglePersonalView.m
//  单个人的信息介绍视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SinglePersonalView.h"

@implementation SinglePersonalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"SinglePersonalView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        if (kIphone6plus) {
            protraitimgWidth.constant = protraitimgWidth.constant+5;
            protraitimgHeight.constant = protraitimgHeight.constant+5;
            protraitToTop.constant = protraitToTop.constant+3;
            
            rateHeight.constant = rateHeight.constant+4;
            rateWidth.constant = rateWidth.constant+6;
            rateLab.font = [UIFont systemFontOfSize:10.5];
            rateLab.backgroundColor = Rgb(251, 118, 106, 1.0);
            
            infoBgToTop.constant = 13;
            
            jobLab.font = [UIFont systemFontOfSize:14.5];
            proLab.font = [UIFont systemFontOfSize:13.5];
        }
        
        
        
        //设置头像圆角
        protraitImg.layer.cornerRadius = protraitimgHeight.constant/2;
        //设置匹配度视图圆角
        rateLab.layer.masksToBounds = YES;
        rateLab.layer.cornerRadius = rateHeight.constant/2;

        
    }
    return self;
}

//初始化子视图数据
-(void)loadSubView:(NSDictionary*)dictionary
{
    if (dictionary!=nil) {
        protraitImg.backgroundColor = [Util randomColor];
        rateLab.text = [NSString stringWithFormat:@"匹配度%ld%%",(long)[Util randomRate]];
        NSString *jobString = [dictionary objectForKey:@"job"];
        jobLab.text = jobString;
        
        nameLab.text = [dictionary objectForKey:@"name"];
        proLab.text = [dictionary objectForKey:@"pro"];
    }
}
@end

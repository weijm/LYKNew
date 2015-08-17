//
//  SinglePersonalView.m
//  单个人的信息介绍视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SinglePersonalView.h"
#import "UIImageView+WebCache.h"

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
        protraitImg.layer.masksToBounds = YES;
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
        NSString *urlString = [Util getCorrectString:[dictionary objectForKey:@"head_img"]];
        if ([urlString length]>0) {
            [protraitImg sd_setImageWithURL:[NSURL URLWithString:urlString]];
        }else
        {
            protraitImg.backgroundColor = [Util randomColor];
        }
        
        rateLab.text = [NSString stringWithFormat:@"匹配度%.0f%%",[[dictionary objectForKey:@"result_value"] floatValue]*100];
        NSString *jobString = [Util getCorrectString:[dictionary objectForKey:@"job_name"]];
        if ([jobString length]>4) {
            jobLab.text = [jobString substringToIndex:4];
        }else
        {
            jobLab.text = jobString;
        }
        
        
//        nameLab.text = [dictionary objectForKey:@"name"];
        NSString *content = [NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"school_name"],[dictionary objectForKey:@"college"]];
        proLab.text = content;
    }else
    {
        jobLab.text = @"";
        proLab.text = @"";
   
    }
}
@end

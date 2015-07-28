//
//  SinglePersonalView.m
//  单个人的信息介绍视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SinglePersonalView.h"

@implementation SinglePersonalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *containerView = [[[UINib nibWithNibName:@"SinglePersonalView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        //设置头像圆角
        protraitImg.layer.cornerRadius = protraitImg.frame.size.width/2;
        //设置匹配度视图圆角
        rateLab.layer.masksToBounds = YES;
        rateLab.layer.cornerRadius = rateLab.frame.size.height/2;
        
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

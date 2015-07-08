//
//  CommendView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendView.h"

@implementation CommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CommendView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(void)loadSubView:(NSArray*)array
{
    [self setPortraitData:array];
    [self setInfo:array];
}
//初始化头像的数据
-(void)setPortraitData:(NSArray*)array
{
    //头像 匹配度赋值数据
    for (int i =0; i<5; i++) {
        UIImageView *portaitImg = (UIImageView *)[portraitBg viewWithTag:i+1];
        UILabel *matchRateLab = (UILabel*)[portraitBg viewWithTag:(i+1)*10];
        if (portaitImg) {
            //赋值头像
            portaitImg.backgroundColor = [Util randomColor];
            matchRateLab.text = [NSString stringWithFormat:@"匹配度%.1f%%",[Util randomRate]];
        }else
        {
            UIView *subBg = [portraitBg viewWithTag:(i+1)*100];
            if (subBg) {//针对2、4头像赋值
                portaitImg = (UIImageView *)[subBg viewWithTag:i];
                portaitImg.backgroundColor = [Util randomColor];
                matchRateLab = (UILabel*)[subBg viewWithTag:(i+1)*10];
                matchRateLab.text = [NSString stringWithFormat:@"匹配度%f%%",[Util randomRate]];
            }
        }
        //设置圆角
        portaitImg.layer.cornerRadius = portaitImg.frame.size.width/2;
        matchRateLab.layer.masksToBounds = YES;
        matchRateLab.layer.cornerRadius = matchRateLab.frame.size.height/2;
    }

}
//初始化岗位 专业信息等
-(void)setInfo:(NSArray*)array
{
    UILabel *jobLab;
    UILabel *nameLab;
    UILabel *proLab;
    for (int i =0; i<5; i++) {
        NSDictionary *dictionary = [array objectAtIndex:i];
        UIView *ibg = [infoBg viewWithTag:(i+1)];
        if (!ibg)
        {
            UIView *subView = [infoBg viewWithTag:(i+1)*100];
            ibg = [subView viewWithTag:(i+1)];
        }
        
        jobLab = (UILabel *)[ibg viewWithTag:1];
        nameLab = (UILabel *)[ibg viewWithTag:2];
        proLab = (UILabel *)[ibg viewWithTag:3];
        
        NSLog(@"info tag == %d",ibg.tag);

        if ([jobLab isKindOfClass:[UILabel class]]) {
            jobLab.text = [dictionary objectForKey:@"job"];
            nameLab.text = [dictionary objectForKey:@"name"];
            proLab.text = [dictionary objectForKey:@"pro"];
        }
        
    }
    
}
@end

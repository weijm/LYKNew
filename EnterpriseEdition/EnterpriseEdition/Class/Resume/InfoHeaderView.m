//
//  InfoHeaderView.m
//  简介详情的headerView
//
//  Created by wjm on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoHeaderView.h"
#import "UIImageView+WebCache.h"

@implementation InfoHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"InfoHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        protraitImag.layer.cornerRadius = protraitImag.frame.size.height/2;
        protraitImag.layer.masksToBounds = YES;
        rateLab.layer.cornerRadius = rateLab.frame.size.height/2;
        rateLab.layer.masksToBounds = YES;
        
        expLab.layer.cornerRadius = expLab.frame.size.height/2;
        expLab.layer.masksToBounds = YES;
        expLab.layer.borderWidth = 1;
       
        expLab.layer.borderColor = [UIColor colorWithRed:0.918 green:0.667 blue:0.494 alpha:1.0].CGColor;
        
        
    }
    return self;
}
-(void)loadData:(NSDictionary*)dictionary
{
    if (dictionary != nil && [dictionary isKindOfClass:[NSDictionary class]]) {
        NSString *nation = [CombiningData getNationStringByID:[[dictionary objectForKey:@"nation_id"] intValue]];
        int sexIndex = [[dictionary objectForKey:@"sex"] intValue];
        NSString *sexString = (sexIndex==0)?@"男":@"女";
        NSString *pImg = (sexIndex==0)?@"resume_protrait_man_default":@"resume_protrait_weman_default";
        [protraitImag sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"head_img"]]placeholderImage:[UIImage imageNamed:pImg]];
        infoLab.text = [NSString stringWithFormat:@"%@ %@ %@",sexString,nation,[dictionary objectForKey:@"birthday"]];
        
        expLab.text = [self getExpByIndex:[[dictionary objectForKey:@"fresh"] intValue]];
    }
}
-(NSString*)getExpByIndex:(int)index
{
    if(index ==0)
    {
        return @"无工作经验";
    }else if(index == 1)
    {
        return @"有工作经验";
    }else
    {
        return @"未填";
    }
}
-(void)loadStatus:(NSDictionary*)dictionary
{
    if (dictionary!=nil) {
        if ([[dictionary objectForKey:@"emergent"] intValue]==0) {
            urgentView.hidden = YES;
        }else
        {
            urgentView.hidden = NO;
        }
        
        if ([[dictionary objectForKey:@"eval"] intValue]==0) {
            editView.hidden = YES;
        }else
        {
            editView.hidden = NO;
        }
        if ([[dictionary objectForKey:@"download"] intValue]==0) {
            download.hidden = YES;
        }else
        {
            download.hidden = NO;
        }
    }
}
@end

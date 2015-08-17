//
//  CellMiddleView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellMiddleView.h"
#import "UIImageView+WebCache.h"

@implementation CellMiddleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CellMiddleView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        
        if (kIphone5||kIphone4) {
            firstLab.font = [UIFont systemFontOfSize:13];
            secondLab.font = [UIFont systemFontOfSize:11];
            thirdLab.font = [UIFont systemFontOfSize:11];
        }
        protraitImg.layer.cornerRadius = protraitImg.frame.size.width/2;
        protraitImg.layer.masksToBounds = YES;
        experienceLab.layer.cornerRadius = experienceLab.frame.size.height/2;
        experienceLab.layer.masksToBounds = YES;
    }
    return self;
}

-(void)loadData:(NSDictionary *)dictionary
{
    NSString *urlString = [Util getCorrectString:[dictionary objectForKey:@"head_img"]];
    NSString *sexString = [dictionary objectForKey:@"sex"];
    NSString *defaultStr = nil;
    if ([sexString isEqualToString:@"女"]) {
        defaultStr = @"resume_protrait_weman_default";
    }else
    {
        defaultStr = @"resume_protrait_man_default";
   
    }
    
    if ([urlString length]>0) {
        [protraitImg sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultStr]];
    }else
    {
        protraitImg.image = [UIImage imageNamed:defaultStr];
    }
    
    
    if ([[dictionary objectForKey:@"internships"] intValue]==1) {
        experienceLab.text = @"有工作经验";;
        experienceLab.hidden = NO;
    }else
    {
        experienceLab.hidden = YES;
    }
    
    
    firstLab.text = [NSString stringWithFormat:@"%@  %@  %@",[dictionary objectForKey:@"full_name"],[dictionary objectForKey:@"sex"],[dictionary objectForKey:@"job_type"]];
    secondLab.text = [NSString stringWithFormat:@"%@ | %@ | %@ | %@",[dictionary objectForKey:@"birthday"],[Util getCorrectString:[dictionary objectForKey:@"certificate_type"]],[dictionary objectForKey:@"salary"],[Util getCorrectString:[dictionary objectForKey:@"employment_type"]]];
    NSString *major_name = [Util getCorrectString:[dictionary objectForKey:@"major_name"]];
    NSString *school_name = [Util getCorrectString:[dictionary objectForKey:@"school_name"]];
    if ([major_name length]>0&&[school_name length]>0) {
        thirdLab.text = [NSString stringWithFormat:@"%@ | %@",major_name,school_name];
    }else if([major_name length]>0&&[school_name length]==0)
    {
        thirdLab.text = [NSString stringWithFormat:@"%@",major_name];
   
    }else if([major_name length]==0&&[school_name length]>0)
    {
        thirdLab.text = [NSString stringWithFormat:@"%@",school_name];
    }else
    {
        thirdLab.text = @"学校专业暂无";
    }
    
}
@end

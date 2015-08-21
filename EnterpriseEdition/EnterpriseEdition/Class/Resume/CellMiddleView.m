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
    
    
    NSString *fstr1 = [Util getCorrectString:[dictionary objectForKey:@"full_name"]];
    NSString *fstr2 = [Util getCorrectString:[dictionary objectForKey:@"sex"]];
    NSString *fstr3 = [Util getCorrectString:[dictionary objectForKey:@"job_type"]];
    if (fstr1 == nil) {
        fstr1 = @"";
    }
    if (fstr2 == nil) {
        fstr2 = @"";
    }
    if (fstr3 == nil) {
        fstr3 = @"";
    }
    firstLab.text = [NSString stringWithFormat:@"%@  %@  %@",fstr1,fstr2,fstr3];
    if ([fstr1 length]==0&&[fstr2 length]==0&&[fstr3 length]==0) {
        firstLab.text = @"暂无";
    }
    
    fstr1 = [Util getCorrectString:[dictionary objectForKey:@"birthday"]];
    fstr2 = [Util getCorrectString:[dictionary objectForKey:@"certificate_type"]];
    fstr3 = [Util getCorrectString:[dictionary objectForKey:@"salary"]];
    NSString *fstr4 = [Util getCorrectString:[dictionary objectForKey:@"employment_type"]];
    if ([fstr2 length]>0) {
        fstr2 = [NSString stringWithFormat:@" | %@",fstr2];
    }
    if ([fstr3 length]>0) {
        fstr3 = [NSString stringWithFormat:@" | %@",fstr3];
    }
    
    if ([fstr4 length]>0) {
        fstr4 = [NSString stringWithFormat:@" | %@",fstr4];
    }
    
    secondLab.text = [NSString stringWithFormat:@"%@%@%@%@",fstr1,fstr2,fstr3,fstr4];
    
    
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

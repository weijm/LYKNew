//
//  ExperienceView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ExperienceView.h"

@implementation ExperienceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ExperienceView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
-(void)loadData:(NSDictionary*)dictioanry
{
    if (dictioanry!=nil&&[dictioanry isKindOfClass:[NSDictionary class]]) {
        timeLab.text = [NSString stringWithFormat:@"%@--%@",[dictioanry objectForKey:@"start_date"],[dictioanry objectForKey:@"end_date"]];
        orgLab.text = [dictioanry objectForKey:@"company_name"];
        positionLab.text = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictioanry objectForKey:@"job_type_name"]],[dictioanry objectForKey:@"industry_name"]];
        NSString *jobContent = [dictioanry objectForKey:@"job_description"];
        contentLab.text = [jobContent stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
        CGSize theStringSize = [contentLab.text sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
        if (theStringSize.width <200) {
//            contentLab.frame = CGRectMake(contentLab.frame.origin.x+10, contentLab.frame.origin.y+20, theStringSize.width, theStringSize.height);
        }else
        {
            contentLab.frame = CGRectMake(contentLab.frame.origin.x, contentLab.frame.origin.y, theStringSize.width, theStringSize.height);
        }
      

        
    }
}
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 300;
    }else if (kIphone6)
    {
        return 290;
    }
    else
    {
        return 222;
    }
}
-(float)getLabFontSize
{
    if (kIphone4||kIphone5) {
        return 13;
    }else if(kIphone6)
    {
        return 10;
    }else
    {
        return 8;
    }
}


@end

//
//  EducationView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/10.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EducationView.h"

@implementation EducationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"EducationView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(void)loadData:(NSDictionary*)dictionary
{
    if (dictionary!=nil&&[dictionary isKindOfClass:[NSDictionary class]]) {
        NSString *endTime = [self getEndTime:[dictionary objectForKey:@"end_year"] Month:[dictionary objectForKey:@"end_month"]];
        timeLab.text = [NSString stringWithFormat:@"%@/%@-%@",[dictionary objectForKey:@"start_year"],[dictionary objectForKey:@"start_month"],endTime];
        schoolLab.text = [NSString stringWithFormat:@"%@ | %@",[dictionary objectForKey:@"school_name"],[dictionary objectForKey:@"college"]];
        proLab.text = [NSString stringWithFormat:@"%@ | %@ | %@",[dictionary objectForKey:@"major_name"],[CombiningData getCertificateType:[[dictionary objectForKey:@"certificate_type"] intValue]],[dictionary objectForKey:@"major_name"]];
    }
}
-(NSString*)getEndTime:(NSString*)endYear Month:(NSString*)endMonth
{
    if ([[[endYear class] description] isEqualToString:@"NSNull"]&&[[[endMonth class] description] isEqualToString:@"NSNull"]) {
        return @"至今";
    }else
    {
        return [NSString stringWithFormat:@"%@/%@",endYear,endMonth];
    }
}
@end

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
//        UIView *containerView = [[[UINib nibWithNibName:@"EducationView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
//        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        containerView.frame = newFrame;
//        [self addSubview:containerView];
    }
    return self;
}

-(void)loadData:(NSDictionary*)dictionary
{
    if (dictionary!=nil&&[dictionary isKindOfClass:[NSDictionary class]]) {
        NSString *endTime = [self getEndTime:[dictionary objectForKey:@"end_year"] Month:[dictionary objectForKey:@"end_month"]];
        if ([endTime length]>0) {
            timeLab.text = [NSString stringWithFormat:@"%@/%@-%@",[dictionary objectForKey:@"start_year"],[dictionary objectForKey:@"start_month"],endTime];
        }else
        {
            timeLab.text = [NSString stringWithFormat:@"%@/%@",[dictionary objectForKey:@"start_year"],[dictionary objectForKey:@"start_month"]];
        }
        
        schoolLab.text = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictionary objectForKey:@"school_name"]],[Util getCorrectString:[dictionary objectForKey:@"college"]]];
        NSString *majorName = [Util getCorrectString:[dictionary objectForKey:@"major_name"]];
        if ([majorName isEqualToString:@"专业"]) {
            majorName = @"其他";
        }
        NSString *cerType = [CombiningData getCertificateType:[[dictionary objectForKey:@"certificate_type"] intValue]];
        if ([majorName length]>0&&[cerType length]>0) {
            proLab.text = [NSString stringWithFormat:@"%@ | %@ ",majorName,cerType];
        }else
        {
            proLab.text = [NSString stringWithFormat:@"%@%@ ",majorName,cerType];
        }
        
    }
}
-(void)loadSubView:(NSDictionary*)dictionary
{
     if (dictionary!=nil&&[dictionary isKindOfClass:[NSDictionary class]]) {
         CGRect frame = CGRectMake(0, 0, [self getLabWidth], 18);
         UILabel *dataLab = [[UILabel alloc] initWithFrame:frame];
         dataLab.backgroundColor = [UIColor clearColor];
          NSString *endTime = [self getEndTime:[dictionary objectForKey:@"end_year"] Month:[dictionary objectForKey:@"end_month"]];
         if ([endTime length]>0) {
             dataLab.text = [NSString stringWithFormat:@"%@/%@-%@",[dictionary objectForKey:@"start_year"],[dictionary objectForKey:@"start_month"],endTime];
         }else
         {
             dataLab.text = [NSString stringWithFormat:@"%@/%@",[dictionary objectForKey:@"start_year"],[dictionary objectForKey:@"start_month"]];
         }
         dataLab.font = [UIFont systemFontOfSize:12];
         dataLab.textColor = Rgb(0, 0, 0, 0.7);
         [self addSubview:dataLab];
         
         NSString *schString = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictionary objectForKey:@"school_name"]],[Util getCorrectString:[dictionary objectForKey:@"college"]]];
         CGSize theStringSize = [schString sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
         
         frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, theStringSize.height);
         UILabel *schNameLab = [[UILabel alloc] initWithFrame:frame];
         schNameLab.backgroundColor = [UIColor clearColor];
         schNameLab.text = schString;
         schNameLab.font = [UIFont systemFontOfSize:13];
         schNameLab.textColor = Rgb(0, 0, 0, 1);
         schNameLab.numberOfLines = 3;
         [self addSubview:schNameLab];
         
         NSString *majorName = [Util getCorrectString:[dictionary objectForKey:@"major_name"]];
         if ([majorName isEqualToString:@"专业"]) {
             majorName = @"其他";
         }
         NSString *cerType = [CombiningData getCertificateType:[[dictionary objectForKey:@"certificate_type"] intValue]];
         NSString *contentStr = nil;
         if ([majorName length]>0&&[cerType length]>0) {
             contentStr = [NSString stringWithFormat:@"%@ | %@ ",majorName,cerType];
         }else
         {
             contentStr = [NSString stringWithFormat:@"%@%@ ",majorName,cerType];
         }
         theStringSize = [contentStr sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
         
         
         frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, theStringSize.height);
         UILabel *contTilLab = [[UILabel alloc] initWithFrame:frame];
         contTilLab.text = contentStr;
         contTilLab.backgroundColor = [UIColor clearColor];
         contTilLab.font = [UIFont systemFontOfSize:12];
         contTilLab.textColor = Rgb(0, 0, 0, 0.7);
         contTilLab.numberOfLines = 0;
         [self addSubview:contTilLab];
         

     }
}
-(NSString*)getEndTime:(NSString*)endYear Month:(NSString*)endMonth
{
    if ([[[endYear class] description] isEqualToString:@"NSNull"]&&[[[endMonth class] description] isEqualToString:@"NSNull"]) {
        return @"";
    }else
    {
        return [NSString stringWithFormat:@"%@/%@",endYear,endMonth];
    }
}
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 290;
    }else if (kIphone6)
    {
        return 280;
    }
    else
    {
        return 222;
    }
}
@end

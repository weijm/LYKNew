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
        positionLab.text = [NSString stringWithFormat:@"%@ | %@",[dictioanry objectForKey:@"job_type_name"],[dictioanry objectForKey:@"industry_name"]];
        contentLab.text = [dictioanry objectForKey:@"job_description"];
        CGSize theStringSize = [contentLab.text sizeWithFont:contentLab.font constrainedToSize:contentLab.frame.size lineBreakMode:contentLab.lineBreakMode];
        contentLab.frame = CGRectMake(contentLab.frame.origin.x, contentLab.frame.origin.y, theStringSize.width, theStringSize.height);

        
    }
}
@end

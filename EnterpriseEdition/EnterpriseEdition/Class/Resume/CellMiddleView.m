//
//  CellMiddleView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellMiddleView.h"

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
        protraitImg.layer.cornerRadius = protraitImg.frame.size.width;
        experienceLab.layer.cornerRadius = experienceLab.frame.size.height/2;
        experienceLab.layer.masksToBounds = YES;
    }
    return self;
}

-(void)loadData:(NSDictionary *)dictionary
{
    NSString *exp = [dictionary objectForKey:@"experience"];
    if ([exp length]>0) {
        experienceLab.text = exp;
        experienceLab.hidden = NO;
    }else
    {
        experienceLab.hidden = YES;
    }
    firstLab.text = [NSString stringWithFormat:@"%@  %@  %@",[dictionary objectForKey:@"name"],[dictionary objectForKey:@"sex"],[dictionary objectForKey:@"selfjob"]];
    secondLab.text = [NSString stringWithFormat:@"%@ | %@ | %@",[dictionary objectForKey:@"age"],[dictionary objectForKey:@"record"],[dictionary objectForKey:@"money"]];
    thirdLab.text = [NSString stringWithFormat:@"%@ | %@",[dictionary objectForKey:@"professional"],[dictionary objectForKey:@"school"]];
}
@end

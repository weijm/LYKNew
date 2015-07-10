//
//  CellHeaderView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellHeaderView.h"
#import "UIButton+Custom.h"

@implementation CellHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CellHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
//加载数据
-(void)loadData:(NSDictionary*)dictionary
{

    jobLab.text = [dictionary objectForKey:@"job"];
    timeLab.text = [dictionary objectForKey:@"time"];
    
    for (UIView *view in [btbg subviews]) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    float btx = 0;
    float bty = 7.5;
    float edge = [Util myXOrWidth:20];
    float btw = 15;
    
    UIButton *bt;
    int isHidden = [[dictionary objectForKey:@"urgent"] intValue];
    if (isHidden) {
        btx = btx+edge;
        bt = [[UIButton alloc] initWithFrame:CGRectMake(btx, bty, btw, btw)];
        [bt setImage:[UIImage imageNamed:@"resume_prompt1"] forState:UIControlStateNormal];
        bt.tag = 1;
        [bt addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btbg addSubview:bt];
    }
    
    isHidden = [[dictionary objectForKey:@"collected"] intValue];
    if (isHidden) {
        btx = btx+edge;
        bt = [[UIButton alloc] initWithFrame:CGRectMake(btx, bty, btw, btw)];
        [bt setImage:[UIImage imageNamed:@"resume_prompt2"] forState:UIControlStateNormal];
        bt.tag = 2;
        [bt addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btbg addSubview:bt];
    }
    
    isHidden = [[dictionary objectForKey:@"download"] intValue];
    if (isHidden) {
        btx = btx+edge;
        bt = [[UIButton alloc] initWithFrame:CGRectMake(btx, bty, btw, btw)];
        [bt setImage:[UIImage imageNamed:@"resume_prompt3"] forState:UIControlStateNormal];
        bt.tag = 3;
        [bt addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btbg addSubview:bt];
    }
}
-(void)clicked:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    NSLog(@"bt tag == %ld",(long)bt.tag);
}
@end

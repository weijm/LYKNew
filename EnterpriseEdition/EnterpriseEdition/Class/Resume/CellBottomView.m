//
//  CellBottomView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CellBottomView.h"

#define LabCount 4

@implementation CellBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CellBottomView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(void)loadAllLabel:(NSArray*)array
{
    float labHEdge = [Util myXOrWidth:8];
    float labVEdge = [Util myYOrHeight:5];
    
    float labW = (kWidth - [Util myXOrWidth:60])/4-labHEdge;
    float labH = [Util myYOrHeight:15];
    
    NSInteger count = array.count;
    CGRect frame;
    float labx;
    float laby;
    int row ;
    for (int i =0; i < count; i++) {
        NSString *string = [array objectAtIndex:i];
        //横坐标
        labx = (labHEdge+labW)*(i%LabCount);
        //纵坐标
        row = [Util getRow:i+1 eachCount:LabCount];
        laby = (labVEdge+labH)*(row -1)+[Util myYOrHeight:3];
        //frame
        frame = CGRectMake(labx, laby, labW, labH);
        
        UILabel *lab = [[UILabel alloc] initWithFrame:frame];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [Util randomColor];
        lab.text = string;
        lab.layer.cornerRadius = labH/2;
        lab.layer.masksToBounds = YES;
        [subBg addSubview:lab];
        
    }
    
}


@end

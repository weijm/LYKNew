//
//  TopImgBotTitleView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "TopImgBotTitleView.h"

@implementation TopImgBotTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"TopImgBotTitleView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
-(void)loadData:(int)count
{
    switch (self.tag) {
        case 0:
            countLab.text = @"20";
            titLab.text = @"当日剩余下载次数";
            break;
        case 1:
            countLab.text = @"200";
            titLab.text = @"当日收到简历份数";
            break;
        case 2:
            countLab.text = @"400";
            titLab.text = @"当日收藏简历份数";
            break;
            
        default:
            break;
    }
}

@end

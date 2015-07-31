//
//  ItemView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ItemView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        if (kIphone6plus) {
            iconWidth.constant = iconWidth.constant +2;
            iconHeight.constant = iconHeight.constant +2;
        }
       
    }
    return self;
}
-(void)loadData
{
    switch (self.tag) {
        case 0:
            _contentLab.text = @"3K-5K";
            break;
        case 1:
            _contentLab.text = @"30人";
            break;
        case 2:
            _contentLab.text = @"全职";
            break;
        case 3:
            _contentLab.text = @"经验不限";
            break;
        case 4:
            _contentLab.text = @"大专以上";
            break;
        case 5:
        {
            labHeight.constant = 40;
            _contentLab.numberOfLines = 2;
            
            _contentLab.text = @"工作地点工作地点工作地点工作地点工作地点工作地点工作地点";
            //当地址为两行时 图标向上移动
            int line = [Util getRow:(int)[_contentLab.text length] eachCount:20];
            if (line >= 2) {
                iconY.constant = (kIphone6plus)?4:7;
            }
        }
            break;
                default:
            break;
    }
}

@end

//
//  ResumeChooseBtView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"

@implementation ResumeChooseBtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"ResumeChooseBtView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
-(void)loadSubView
{
    switch (self.tag) {
        case 0:
            [_chooseBt setTitle:@"收到的简历" forState:UIControlStateNormal];
            _chooseBt.backgroundColor = Rgb(16, 117, 224, 1.0);
            [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_chooseBt setTitle:@"收藏的简历" forState:UIControlStateNormal];
            break;
        case 2:
            [_chooseBt setTitle:@"已下载的简历" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)clickedAction:(id)sender {
    _chooseBt.backgroundColor = Rgb(16, 117, 224, 1.0);
    [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.clickedBtAction(self.tag);
    
}


@end

//
//  HireOfView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/30.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HireOfView.h"
#import "SingleHireButton.h"
#define kTotaleItemCount 6
#define kItemCount 3

@implementation HireOfView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"HireOfView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        if (kIphone6plus) {
            cornerImgWidth.constant = cornerImgWidth.constant+3;
            cornerImgHeight.constant = cornerImgHeight.constant+3;
            hire.font = [UIFont systemFontOfSize:13];
        }
    }
    return self;
}
-(void)loadItem:(NSArray*)array
{
    for (UIView *view in [topBg subviews]) {
        if ([view isKindOfClass:[SingleHireButton class]]) {
            [view removeFromSuperview];
        }
    }
    for (UIView *view in [bottomBg subviews]) {
        if ([view isKindOfClass:[SingleHireButton class]]) {
            [view removeFromSuperview];
        }
    }
    float edgeToLeft = 0;
    float itemW = (kWidth - edgeToLeft*2)/kItemCount;
    float itemH = topBg.frame.size.height;
    int   index = 0;//第几个按钮
    UIView *subView = topBg;
    NSDictionary *dic;
    float itemY = 0;
    if (kIphone4||kIphone5) {
        itemY = 10;
    }
    for (int i =0; i < kTotaleItemCount; i++)
    {
        dic = [array objectAtIndex:i];
        index = i;
        if (i>=kItemCount) {
            index = i-kItemCount;
            subView = bottomBg;
        }
        float itemX = edgeToLeft + itemW*index;
        CGRect frame = CGRectMake(itemX, itemY, itemW, itemH);
        SingleHireButton *itemView = [[SingleHireButton alloc] initWithFrame:frame];
        itemView.tag = i;
        itemView.isValid = _isValid;
        [itemView loadSubViewAndData:dic];
        itemView.clickedItem = ^(int index){
            [self clickedItemAction:index];
        };
        [subView addSubview:itemView];
    }
}
-(void)clickedItemAction:(int)index
{
    self.clickedHire(index);
}
@end

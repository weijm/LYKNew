//
//  CommendView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendView.h"
#import "SinglePersonalView.h"
#define kPersonCount (kIphone4||kIphone5)?4:5
@implementation CommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"CommendView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        if (kIphone6plus) {
            arrowHeight.constant = arrowHeight.constant+1;
            arrowWidth.constant = arrowWidth.constant+1;
            
            titBgToTop.constant = 7.5;
            titBgHeight.constant = titBgHeight.constant+3;
            titLab.font = [UIFont systemFontOfSize:17];
            
            cornerImgWidth.constant = cornerImgWidth.constant+4;
            cornerImgHeight.constant = cornerImgHeight.constant+4;
            commendLab.font = [UIFont systemFontOfSize:14];
        }
    }
    return self;
}
//加载子视图的数据
-(void)loadSubView:(NSArray*)array
{
    int count = kPersonCount;
    float edgeToLeft = 0;
    float singleW = (kWidth-edgeToLeft*2)/count;
    float singleH = bottombg.frame.size.height;
    CGRect frame ;
    for (int i =0; i<count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        
        frame = CGRectMake(edgeToLeft + singleW*i, 0, singleW, singleH);
        SinglePersonalView *singleView = [[SinglePersonalView alloc] initWithFrame:frame];
        singleView.tag = i;
        //初始化子视图数据
        [singleView loadSubView:dic];
        [bottombg addSubview:singleView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [singleView addGestureRecognizer:tap];
    }
    
}
//点击查看某人简历的触发事件
-(void)tapAction:(UITapGestureRecognizer*)sender
{
    NSInteger tag = sender.view.tag;
    self.clickPersonalInfo(tag);
}
- (IBAction)clickedMoreBt:(id)sender {
    //查看更多
    UIButton *bt = (UIButton*)sender;
    self.clickPersonalInfo(bt.tag);
}
@end

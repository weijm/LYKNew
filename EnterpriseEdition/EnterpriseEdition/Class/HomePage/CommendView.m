//
//  CommendView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendView.h"
#import "SinglePersonalView.h"

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
    }
    return self;
}
//加载子视图的数据
-(void)loadSubView:(NSArray*)array
{
    for (int i =0; i<5; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        SinglePersonalView *singleView = (SinglePersonalView *)[bottombg viewWithTag:(i+1)];
        if (!singleView) {
            UIView *subBg = [bottombg viewWithTag:(i+1)*100];
            singleView = (SinglePersonalView *)[subBg viewWithTag:i+1];
        }
        //初始化子视图数据
        [singleView loadSubView:dic];
        
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

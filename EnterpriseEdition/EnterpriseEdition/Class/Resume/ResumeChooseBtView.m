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
// 初始化按钮
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
//初始化底部视图上的按钮
-(void)loadFooterSubView
{
    vline.backgroundColor = Rgb(181, 181, 187, 1.0);
    _chooseBt.backgroundColor = Rgb(220, 221, 227, 1.0);
    [_chooseBt setTitleColor:Rgb(57, 57, 58, 1.0) forState:UIControlStateNormal];
    NSInteger index = self.tag;
    if (index >=10 && index < 100) {
        switch (index) {
            case 10:
                [_chooseBt setTitle:@"全  选" forState:UIControlStateNormal];
                break;
            case 20:
                [_chooseBt setTitle:@"收藏选中的简历" forState:UIControlStateNormal];
                break;
            case 30:
                [_chooseBt setTitle:@"删除选中的简历" forState:UIControlStateNormal];
                vline.hidden = YES;
                break;
                
            default:
                break;
        }
    }else if (index >=100 && index<1000)
    {
        switch (index) {
            case 100:
                [_chooseBt setTitle:@"全  选" forState:UIControlStateNormal];
                break;
            case 200:
                [_chooseBt setTitle:@"取消收藏选中简历" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }else
    {
        switch (index) {
            case 1000:
                [_chooseBt setTitle:@"全  选" forState:UIControlStateNormal];
                break;
            case 2000:
                [_chooseBt setTitle:@"收藏选中的简历" forState:UIControlStateNormal];
                break;
            case 3000:
                [_chooseBt setTitle:@"删除选中的简历" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}
// 点击事件
- (IBAction)clickedAction:(id)sender {
    if (self.tag <10) {//头部视图按钮
        _chooseBt.backgroundColor = Rgb(16, 117, 224, 1.0);
        [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
   
    self.clickedBtAction(self.tag);
    
}


@end

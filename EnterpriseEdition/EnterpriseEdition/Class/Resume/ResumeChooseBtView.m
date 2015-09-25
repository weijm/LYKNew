//
//  ResumeChooseBtView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeChooseBtView.h"
#import "UIButton+Custom.h"

#define FontSize (kIphone6||kIphone6plus)?17:15
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
        [_chooseBt setTitleColor:Rgb(2, 139, 230, 1.0) forState:UIControlStateNormal];
        if (kIphone5||kIphone4) {
            _chooseBt.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        vline.backgroundColor = Rgb(2, 139, 230, 1.0);
    }
    return self;
}
// 初始化按钮
-(void)loadSubView
{
//    if (kIphone4||kIphone5) {
//        _chooseBt.titleLabel.font = [UIFont systemFontOfSize:12];
//    }else
//    {
//        _chooseBt.titleLabel.font = [UIFont systemFontOfSize:14];
//    }
    
    switch (self.tag) {
        case 0:
            [_chooseBt setTitle:@"收到" forState:UIControlStateNormal];
            _chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
            [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_chooseBt setTitle:@"收藏" forState:UIControlStateNormal];
            break;
        case 2:
            [_chooseBt setTitle:@"已下载" forState:UIControlStateNormal];
            break;
        case 3:
            [_chooseBt setTitle:@"招聘会" forState:UIControlStateNormal];
            break;

        default:
            break;
    }
}
-(void)loadSubViewInNowHiring
{
    switch (self.tag) {
        case 0:
            [_chooseBt setTitle:@"收到的简历" forState:UIControlStateNormal];
            _chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
            [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_chooseBt setTitle:@"简历推荐" forState:UIControlStateNormal];
            break;
        
            break;
        default:
            break;
    }

}
//初始化底部视图上的按钮
-(void)loadFooterSubView
{
    vline.backgroundColor = Rgb(204, 204, 207, 1.0);
    _chooseBt.backgroundColor = Rgb(227, 227, 231, 1.0);
    [_chooseBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseBt.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    NSInteger index = self.tag;
    if (index >=10 && index < 100) {
        switch (index) {
            case 10:
                [_chooseBt setTitle:@"全   选" forState:UIControlStateNormal];
                break;
            case 20:
                [_chooseBt setTitle:@"收藏选中简历" forState:UIControlStateNormal];
                break;
            case 30:
                [_chooseBt setTitle:@"删除选中简历" forState:UIControlStateNormal];
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
                [_chooseBt setTitle:@"收藏选中简历" forState:UIControlStateNormal];
                break;
            case 3000:
                [_chooseBt setTitle:@"删除选中简历" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}
//初始化职位底部视图上的按钮
-(void)loadPositionFooterSubView
{
    vline.backgroundColor = Rgb(204, 204, 207, 1.0);
    _chooseBt.backgroundColor = Rgb(227, 227, 231, 1.0);
    [_chooseBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseBt.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    NSInteger index = self.tag;
    if (index >=10 && index < 100) {
        switch (index) {
            case 10:
                [_chooseBt setTitle:@"全  选" forState:UIControlStateNormal];
                break;
            case 20:
                [_chooseBt setTitle:@"刷新" forState:UIControlStateNormal];
                break;
            case 30:
                [_chooseBt setTitle:@"删除" forState:UIControlStateNormal];
                break;
            case 40:
                [_chooseBt setTitle:@"下线" forState:UIControlStateNormal];
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
                [_chooseBt setTitle:@"删除选中职位" forState:UIControlStateNormal];
                break;
            case 300:
                [_chooseBt setTitle:@"上线选中职位" forState:UIControlStateNormal];
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
                [_chooseBt setTitle:@"删除选中职位" forState:UIControlStateNormal];
                break;
           
            default:
                break;
        }
    }

}
//初始化职位详情底部视图上的按钮
-(void)loadPositionInfoFooterSubView
{
    vline.backgroundColor = Rgb(204, 204, 207, 1.0);
    _chooseBt.backgroundColor = Rgb(227, 227, 231, 1.0);
    [_chooseBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseBt.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    NSInteger index = self.tag;
    switch (index) {
        case 10:
            [_chooseBt setTitle:@"操  作" forState:UIControlStateNormal];
            break;
        case 20:
            [_chooseBt setTitle:@"设置急招" forState:UIControlStateNormal];
            break;
        case 30:
            [_chooseBt setTitle:@"编  辑" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
//初始化职位详情底部视图上的按钮
-(void)loadInfoInfoFooterSubView
{
    vline.backgroundColor = Rgb(204, 204, 207, 1.0);
    _chooseBt.backgroundColor = Rgb(227, 227, 231, 1.0);
    [_chooseBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseBt.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    NSInteger index = self.tag;
    switch (index) {
        case 100:
            [_chooseBt setTitle:@"置为已读" forState:UIControlStateNormal];
            break;
        case 200:
            [_chooseBt setTitle:@"删    除" forState:UIControlStateNormal];
            break;
       
        default:
            break;
    }
}
//初始化认领职位底部视图上的按钮
-(void)loadClaimPositionFooterView
{
    vline.backgroundColor = Rgb(204, 204, 207, 1.0);
    _chooseBt.backgroundColor = Rgb(227, 227, 231, 1.0);
    [_chooseBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chooseBt.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    NSInteger index = self.tag;
    switch (index) {
        case 10:
            [_chooseBt setTitle:@"全  选" forState:UIControlStateNormal];
            break;
        case 20:
            [_chooseBt setTitle:@"认领选中职位" forState:UIControlStateNormal];
            break;
        case 30:
            [_chooseBt setTitle:@"下一步" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
// 初始化职位中的按钮
-(void)loadSubViewInPosition
{
    switch (self.tag) {
        case 0:
            [_chooseBt setTitle:@"有效职位" forState:UIControlStateNormal];
            _chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
            [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_chooseBt setTitle:@"下线职位" forState:UIControlStateNormal];
            break;
        case 2:
            [_chooseBt setTitle:@"待审核职位" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
// 初始化招聘会中的按钮
-(void)loadSubViewInJobFair
{
    switch (self.tag) {
        case 0:
            [_chooseBt setTitle:@"全  部" forState:UIControlStateNormal];
            _chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
            [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_chooseBt setTitle:@"我  的" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

// 点击事件
- (IBAction)clickedAction:(id)sender {
    if (self.tag <10) {//头部视图按钮
        _chooseBt.backgroundColor = Rgb(2, 139, 230, 1.0);
        [_chooseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
   
    self.clickedBtAction(self.tag);
    
}


@end

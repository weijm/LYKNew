//
//  InfoHeaderView.h
//  简介详情的headerView
//
//  Created by wjm on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoHeaderView : UIView
{
    //背景图
    __weak IBOutlet UIImageView *bgImage;
    //头像
    __weak IBOutlet UIImageView *protraitImag;
    //匹配度label
    __weak IBOutlet UILabel *rateLab;
    
    //信息lab
    __weak IBOutlet UILabel *infoLab;
    //经验信息label
    __weak IBOutlet UILabel *expLab;
    
    //急
    __weak IBOutlet UIImageView *urgentView;
    //编辑
    __weak IBOutlet UIImageView *editView;
    //下载
    __weak IBOutlet UIImageView *download;
    
    __weak IBOutlet UIView *stateBg;
    
    __weak IBOutlet NSLayoutConstraint *proWidth;
    __weak IBOutlet NSLayoutConstraint *proHeight;
    
}
@property(nonatomic) int internships;//0无 1有
-(void)loadData:(NSDictionary*)dictionary;
-(void)loadStatus:(NSDictionary*)dictionary;
@end

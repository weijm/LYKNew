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
    IBOutlet UIImageView *bgImage;
    //头像
    IBOutlet UIImageView *protraitImag;
    //匹配度label
    
    IBOutlet UILabel *rateLab;
    //信息lab
    IBOutlet UILabel *infoLab;
    //经验信息label
    
    IBOutlet UILabel *expLab;
    //急
    IBOutlet UIImageView *urgentView;
    //编辑
    IBOutlet UIImageView *editView;
    //下载
    IBOutlet UIImageView *download;
    //收藏
    IBOutlet UIImageView *collectedView;
    
}
@end

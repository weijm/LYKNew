//
//  ResumeViewController.h
//  简历首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResumeTableViewCell.h"
//#import "FiltrateView.h"

@interface ResumeViewController : BaseViewController<ResumeTableViewCellDelegate>
{
    
}
//从首页点击进入
-(void)loadStatusFromHomePage:(int)index;



@end

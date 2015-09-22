//
//  JobFairListTableViewCell.h
//  招聘会列表cell
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobFairListTableViewCell : UITableViewCell
{
    UIImageView *locationImg;
    NSString *picUrl;
}
//报名事件
@property(nonatomic,copy) void(^clickedAction)(int index,BOOL isResume);
//是否是我的里面的cell
@property(nonatomic) BOOL isMy;
//初始化数据
-(void)loadSubView:(NSDictionary*)dictionary;

//初始化招聘会详情cell
-(void)loadSubViewInInfo:(NSDictionary*)dictionary;
@end

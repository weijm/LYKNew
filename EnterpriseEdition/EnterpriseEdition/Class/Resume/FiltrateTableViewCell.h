//
//  FiltrateTableViewCell.h
//  筛选cell视图
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltrateTableViewCell : UITableViewCell
{
//    __weak IBOutlet UIView *contentBg;
   
}
//编辑的内容
@property (strong, nonatomic) IBOutlet UITextField *contentTextFiled;
//每行的标题
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (strong,nonatomic)IBOutlet UIView *contentBg;
/**
 加载默认信息
 */
-(void)loadDefaultInfo;
/**
 重置编辑视图
 */
-(void)resetEditTextField;
/**
 设置编辑内容
 */
-(void)setEditContent:(NSObject*)object;
@end

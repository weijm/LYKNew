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
    IBOutlet UIView *contentBg;
    IBOutlet UIView *areBg;
}
//编辑的内容
@property (strong, nonatomic) IBOutlet UITextField *contentTextFiled;
//每行的标题
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
//编辑的市
@property (strong, nonatomic) IBOutlet UITextField *cityTextFiled;
//编辑的省
@property (strong, nonatomic) IBOutlet UITextField *provinceTextFiled;

@property (nonatomic,copy) void(^chooseFiltrateConditions)(NSString* editStr);
/**
 显示什么视图
 */
-(void)showContentView:(int)index;
/**
 重置编辑视图
 */
-(void)resetEditTextField;
/**
 设置编辑内容
 */
-(void)setEditContent:(NSObject*)object;
@end

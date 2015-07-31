//
//  ChangePasswordTableViewCell.h
//  修改密码的Cell
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangePasswordTableViewCellDelegate <NSObject>
@optional
-(void)setEditView:(UIView*)_editView;
//取消键盘
-(void)cancelKey;

@end

@interface ChangePasswordTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    
    IBOutlet UILabel *titleLab;
    IBOutlet UITextField *contentTextField;
    
    IBOutlet NSLayoutConstraint *lineHeight;
}
@property (nonatomic,weak) id<ChangePasswordTableViewCellDelegate> delegate;
/**
 初始化标题
 */
-(void)loadTitlData;
/**
 设置编辑的内容
 */
-(void)loadContent:(NSObject*)obj;
@end

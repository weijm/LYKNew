//
//  CreateUserTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateUserTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    //每个cell的标题
    IBOutlet UILabel *titleLab;
    //编辑文本框
    IBOutlet UITextField *contentField;
    
    //设置性别视图
    
    IBOutlet UIView *sexBg;
    //横向分割线
    
    IBOutlet UIView *hLine;
}
@property (nonatomic,copy)void(^operateButton)(NSInteger index);
@property (nonatomic,copy)void(^operateTextField)(UITextField *textField);
/**
 初始化创建账号的每个cell
 */
-(void)loadCreateUserCell;
/**
 设置性别事件
 */
- (IBAction)setSexAction:(id)sender;

@end

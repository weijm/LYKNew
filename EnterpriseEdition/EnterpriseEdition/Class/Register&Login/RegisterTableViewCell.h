//
//  RegisterTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/25.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterTableViewCellDelegate <NSObject>
@optional
-(void)setEditView:(UITextField*)_editView;
//取消键盘
-(void)cancelKey;
@end

@interface RegisterTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    //普通视图背景
    IBOutlet UIView *bg;
    //验证码背景
    IBOutlet UIView *codeBg;
    //内容视图
    IBOutlet UITextField *contentTextField;
    IBOutlet UILabel *titleLab;
    
    IBOutlet UILabel *timesLab;
    IBOutlet UITextField *codeTextField;
    
    IBOutlet UIView *hline;
    
}
@property (nonatomic,weak)id <RegisterTableViewCellDelegate> delegate;
/**
 初始化cell上的视图内容
 */
-(void)loadSubView:(NSString*)contentString;
/**
 获取验证码 倒计时
 */
- (IBAction)getCodeTimes:(id)sender;

@end

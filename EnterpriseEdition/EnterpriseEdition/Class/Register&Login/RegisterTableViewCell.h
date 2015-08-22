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

//下一步
-(void)clickedNextBtAction;

//获取验证码
-(void)getCode;

//取消后去验证码加载视图
-(void)cancelGetCodeLoding:(NSString*)string;
@end

@interface RegisterTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    //普通视图背景
    __weak IBOutlet UIView *bg;
    //验证码背景
    __weak IBOutlet UIView *codeBg;
    //内容视图
    IBOutlet UITextField *contentTextField;
    __weak IBOutlet UILabel *titleLab;
    
    __weak IBOutlet UILabel *codeMarkLab;
    __weak IBOutlet UILabel *timesLab;
    __weak IBOutlet UITextField *codeTextField;
    //获取验证码的button
    __weak IBOutlet UIButton *codeBt;
    
    __weak IBOutlet UIView *hline;
    
    NSTimer *codeTimer;
    
    int seconds;
    //获取验证码的位置
    
    __weak IBOutlet NSLayoutConstraint *lineHeight;
    
}
@property (nonatomic,weak)id <RegisterTableViewCellDelegate> delegate;
@property (nonatomic) int  cellType;//0:注册页面的cell 1:忘记密码页面的cell 2:忘记密码中设置密码页面的cell
/**
 初始化cell上的视图内容
 */
-(void)loadSubView:(NSString*)contentString;
/**
 获取验证码 倒计时
 */
- (IBAction)getCodeTimes:(id)sender;
/**
 停止计时器
 */
-(void)stopCodeTimer;
@end

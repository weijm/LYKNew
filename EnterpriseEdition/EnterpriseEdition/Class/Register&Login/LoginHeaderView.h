//
//  LoginHeaderView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginHeaderViewDelegate <NSObject>
@optional
//获取编辑的视图
-(void)setEditTextField:(UITextField*)_textField;
//取消键盘
-(void)cancelKey;
@end
@interface LoginHeaderView : UIView<UITextFieldDelegate>
{
    
    __weak IBOutlet NSLayoutConstraint *numberimgWidth;
    __weak IBOutlet NSLayoutConstraint *numberimgHeight;
    
    __weak IBOutlet NSLayoutConstraint *passwordimgWidth;
    
    __weak IBOutlet NSLayoutConstraint *passwordimgHeight;
    
    __weak IBOutlet NSLayoutConstraint *line1Height;
    
    __weak IBOutlet NSLayoutConstraint *line2Height;
    
    __weak IBOutlet UITextField *numberTextField;
 
    __weak IBOutlet UITextField *passwordTextField;
}
-(void)reloadTextField;
@property(nonatomic,weak) id<LoginHeaderViewDelegate> delegate;
@end

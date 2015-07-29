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
    IBOutlet NSLayoutConstraint *numberimgWidth;
    
    IBOutlet NSLayoutConstraint *numberimgHeight;
    
    IBOutlet NSLayoutConstraint *passwordimgWidth;
    
    IBOutlet NSLayoutConstraint *passwordimgHeight;
}
@property(nonatomic,weak) id<LoginHeaderViewDelegate> delegate;
@end

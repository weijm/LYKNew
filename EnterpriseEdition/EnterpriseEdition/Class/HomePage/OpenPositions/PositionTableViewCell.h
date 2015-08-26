//
//  PositionTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPlaceholderTextView.h"
@protocol PositionTableViewCellDelegate <NSObject>
@optional
-(void)setEditView:(UIView*)_editView;
//取消键盘
-(void)cancelKey;

@end
@interface PositionTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
{
    //标题及星星的背景
    __weak IBOutlet UIView *titleBg;
    //标题
    __weak IBOutlet UILabel *titleLab;
    //箭头
    __weak IBOutlet UIImageView *arrowImg;
    
    __weak IBOutlet UIImageView *markImg;
    
    __weak IBOutlet UITextField *contentTextField;
    
    __weak IBOutlet LPlaceholderTextView *contentTextView;
    __weak IBOutlet NSLayoutConstraint *contentTextFieldToRight;
    
    __weak IBOutlet NSLayoutConstraint *titBgToBottom;
    
    __weak IBOutlet NSLayoutConstraint *xingHeight;
    __weak IBOutlet NSLayoutConstraint *xingWidth;
    
    __weak IBOutlet NSLayoutConstraint *lineHeight;
    
}
@property (nonatomic,weak) id<PositionTableViewCellDelegate> delegate;
/**
 初始化标题 提示语
 */
-(void)initData:(NSDictionary*)dictionary;
/**
 设置编辑的内容
 */
-(void)loadContent:(NSObject*)obj;
@end

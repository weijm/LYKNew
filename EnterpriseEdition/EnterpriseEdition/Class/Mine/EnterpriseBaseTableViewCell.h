//
//  EnterpriseBaseTableViewCell.h
//  企业资料编辑内容的cell
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTextViewPlaceholder.h"
@protocol EnterpriseBaseTableViewCellDelegate <NSObject>
@optional
-(void)setEditView:(UIView*)_editView;
//取消键盘
-(void)cancelKey;

@end
@interface EnterpriseBaseTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
{
    //标题及星星的背景
    __weak IBOutlet UIView *titleBg;
    //标题
    __weak IBOutlet UILabel *titleLab;
    //箭头
    __weak IBOutlet UIImageView *arrowImg;
    
    __weak IBOutlet UITextField *contentTextField;
    
    __weak IBOutlet CPTextViewPlaceholder *contentTextView;
    
    __weak IBOutlet NSLayoutConstraint *contentTextFieldToRight;
    
    __weak IBOutlet NSLayoutConstraint *titBgToBottom;
    
    __weak IBOutlet NSLayoutConstraint *xingHeight;
    __weak IBOutlet NSLayoutConstraint *xingWidth;
    
    __weak IBOutlet NSLayoutConstraint *lineHeight;
    
    
    __weak IBOutlet UIImageView *markImg;
}
@property (nonatomic,weak) id<EnterpriseBaseTableViewCellDelegate> delegate;
@property (nonatomic) int  cellType;
/**
 初始化标题 提示语
 */
-(void)initData:(NSDictionary*)dictionary;
/**
 设置编辑的内容
 */
-(void)loadContent:(NSObject*)obj;
@end

//
//  PositionTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PositionTableViewCellDelegate <NSObject>
@optional
-(void)setEditView:(UIView*)_editView;
//取消键盘
-(void)cancelKey;

@end
@interface PositionTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
{
    //标题及星星的背景
    IBOutlet UIView *titleBg;
    //标题
    IBOutlet UILabel *titleLab;
    //箭头
    IBOutlet UIImageView *arrowImg;
    
    IBOutlet UITextField *contentTextField;
    
    IBOutlet UITextView *contentTextView;
    
    IBOutlet NSLayoutConstraint *contentTextFieldToRight;
    
    IBOutlet NSLayoutConstraint *titBgToBottom;
    
    IBOutlet NSLayoutConstraint *xingHeight;
    IBOutlet NSLayoutConstraint *xingWidth;
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

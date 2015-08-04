//
//  EnterpriseBaseTableViewCell.m
//  企业资料编辑内容的cell
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EnterpriseBaseTableViewCell.h"

@implementation EnterpriseBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        xingHeight.constant = xingHeight.constant+1;
        xingWidth.constant = xingWidth.constant+1;
    }
    lineHeight.constant = 0.5;
    contentTextView.backgroundColor = Rgb(245, 245, 245, 1.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initData:(NSDictionary*)dictionary
{
    titleLab.text = [dictionary objectForKey:@"title"];
    contentTextField.placeholder = [dictionary objectForKey:@"placeholder"];
    int index = (int)self.tag;
    
    if (_cellType == 1) {//填写联系人的第二行
        if (index == 1) {
            index = 4;
        }
    }
    
    if (index == 6) {
        arrowImg.hidden = YES;
        contentTextField.hidden = YES;
        contentTextView.hidden = NO;
        titBgToBottom.constant = [Util myYOrHeight:40];
    }else
    {
        if (index == 0||index==4||index==9) {
            arrowImg.hidden = YES;
            contentTextFieldToRight.constant = -8;
            contentTextField.userInteractionEnabled = YES;
        }else
        {
            arrowImg.hidden = NO;
            contentTextFieldToRight.constant = 8;
            contentTextField.userInteractionEnabled = NO;
        }
        contentTextField.hidden = NO;
        contentTextView.hidden = YES;
        titBgToBottom.constant = 0;
        
        
    }
}
-(void)loadContent:(NSObject*)obj
{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)obj;
        NSString *content = [dic objectForKey:@"content"];
        if ([content length]>0) {
            contentTextField.text = content;
        }
        
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(setEditView:)]) {
        textField.tag = self.tag;
        [_delegate setEditView:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(cancelKey)]) {
        [_delegate cancelKey];
    }
    return YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(setEditView:)]) {
        textView.tag = self.tag;
        [_delegate setEditView:textView];
    }
    return YES;
}

@end
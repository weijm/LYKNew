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
-(void)initData:(NSDictionary*)dictionary Content:(NSObject*)obj
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
        NSString *conText = [self getContent:obj];
        if ([conText length]>0) {
            contentTextView.text = conText;
        }else
        {
            contentTextView.placeholderText = @"请输入1000字以内描述";
            contentTextView.placeholderColor = Rgb(0, 0, 0, 0.5);
        }  
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
        contentTextField.text = [self getContent:obj];
    }
    
    //必填的显示星星 非必填的不显示星星
    if (index == 7||index ==9) {
        markImg.hidden = YES;
    }else
    {
        markImg.hidden = NO;
    }
}

-(NSString*)getContent:(NSObject*)obj
{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)obj;
        NSString *content = [dic objectForKey:@"content"];
        if ([content length]>0) {
            return content;
        }
    }
    return @"";
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(_cellType ==1)
    {
        if (self.tag ==0) {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            int stringLength = 15;
            if ([newString length]>stringLength)
            {
                [Util showPrompt:@"不能超过15字"];
                textField.text = [newString substringToIndex:stringLength];
                if ([_delegate respondsToSelector:@selector(cancelKey)]) {
                    [_delegate cancelKey];
                }
                return  NO;
            }
            
        }
    }else
    {
        if (self.tag ==0||self.tag == 4) {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            int stringLength = 30;
            if ([newString length]>stringLength)
            {
                [Util showPrompt:@"不能超过30字"];
                textField.text = [newString substringToIndex:stringLength];
                if ([_delegate respondsToSelector:@selector(cancelKey)]) {
                    [_delegate cancelKey];
                }
                return  NO;
            }
            
        }
    }
    
    
    return YES;
}
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
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.tag ==6) {
        NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
        int stringLength = 1000;
        if ([newString length]>stringLength)
        {
            textView.text = [newString substringToIndex:stringLength];
            [Util showPrompt:@"不能超过1000字"];
            if ([_delegate respondsToSelector:@selector(cancelKey)]) {
                [_delegate cancelKey];
            }
            return  NO;
        }
        
    }
    
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(setEditView:)]) {
        textView.tag = self.tag;
        [_delegate setEditView:textView];
    }
    return YES;
}

@end

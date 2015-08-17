//
//  PositionTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionTableViewCell.h"

@implementation PositionTableViewCell

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
    
    if (index==1||index>=9) {
        markImg.hidden = YES;
    }else
    {
        markImg.hidden = NO;
    }
    
    if (index == 8) {
        arrowImg.hidden = YES;
        contentTextField.hidden = YES;
        contentTextView.hidden = NO;
        contentTextView.placeholder = @"请输入1000字以内描述";
        titBgToBottom.constant = [Util myYOrHeight:70];
    }else
    {
        if (index == 0||index==3||index==7||index==8||index==11||index==12) {
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.tag ==0||self.tag ==11||self.tag ==12) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int stringLength = (self.tag==12)?50:30;
        if ([newString length]>stringLength)
        {
            [textField resignFirstResponder];
            return  NO;
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(setEditView:)]) {
        textView.tag = self.tag;
        [_delegate setEditView:textView];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [contentTextView resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(cancelKey)]) {
            [_delegate cancelKey];
        }
        return NO;
    }
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([newString length]>1000)
    {
        [contentTextView resignFirstResponder];
        return  NO;
    }

    return YES;
}
@end

//
//  ChangePasswordTableViewCell.m
//  修改密码的Cell
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ChangePasswordTableViewCell.h"

@implementation ChangePasswordTableViewCell

- (void)awakeFromNib {
    // Initialization code
    lineHeight.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadTitlData
{
    switch (self.tag) {
        case 0:
            titleLab.text = @"当前密码";
            break;
        case 1:
            titleLab.text = @"新 密 码";
            break;
        case 2:
            titleLab.text = @"确认密码";
            break;
        default:
            break;
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

@end

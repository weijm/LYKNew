//
//  RegisterTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/25.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterTableViewCell.h"

@implementation RegisterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubView:(NSString*)contentString
{
    contentTextField.tag = self.tag;
    
    switch (self.tag) {
        case 0:
            titleLab.text = @"手 机 号";
            contentTextField.placeholder = @"手机号11位数字，不能含有字母";
            
            break;
        case 1:
            titleLab.text = @"设置密码";
            contentTextField.placeholder = @"6-16位数字和字母组合";
            break;
        case 2:
            titleLab.text = @"确认密码";
            contentTextField.placeholder = @"6-16位数字和字母组合";
            
            break;
        case 3:
            codeTextField.tag = 3;
            bg.hidden = YES;
            codeBg.hidden = NO;
            
            break;
        case 4:
        {
            codeBg.hidden = YES;
            hline.hidden = YES;
            titleLab.hidden = YES;
            contentTextField.hidden = YES;
            CGRect frame = CGRectMake(-15,[Util myYOrHeight:80]-[Util myYOrHeight:35] , kWidth-30, [Util myYOrHeight:35]);
            //登录按钮
            UIButton *nextBt = [[UIButton alloc] initWithFrame:frame];
            nextBt.backgroundColor = Rgb(16, 117, 224, 1.0);
            [nextBt setTitle:@"下 一 步" forState:UIControlStateNormal];
            nextBt.tag =1;
            [nextBt addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
            nextBt.layer.cornerRadius = 3.0;
            nextBt.layer.masksToBounds = YES;
            [bg addSubview:nextBt];
        }
            
            break;
            
        default:
            break;
    }
    if ([contentString length]>0) {
        contentTextField.text = contentString;
        codeTextField.text = contentString;
    }
}
- (IBAction)getCodeTimes:(id)sender {
}
-(void)nextAction
{
    NSLog(@"注册 nextAction");
}
#pragma mark - UITextFieldDelegate
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

//
//  RegisterBottomView.m
//  注册页面的 下一步按钮和协议
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterBottomView.h"
#import "CustomLabel.h"
#import "MarkupParser.h"

@implementation RegisterBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"RegisterBottomView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];


        //设置协议字体颜色
        NSString *text = @"<font color=\"lightGray\">注册即视为同意《<font color=\"blue\">E朝朝企业版条款<font color=\"lightGray\">》，系统将为您创建E朝朝账号";
        MarkupParser *p = [[MarkupParser alloc]init ];
        NSAttributedString *attString = [p attrStringFromMarkup:text];
        [agreementLab setAttString:attString];
        agreementLab.font = [UIFont systemFontOfSize:12];
        
        //协议的点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookUp)];
        [agreementLab addGestureRecognizer:tap];
    }
    return self;
}
- (IBAction)agreementAction:(id)sender {
    NSLog(@"agreementAction");
    
}

- (IBAction)nextSpet:(id)sender {
    self.clickedAction(1);
}
-(void)lookUp
{
    self.clickedAction(0);
}
@end

//
//  CreateUserTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CreateUserTableViewCell.h"
#import "UIButton+Custom.h"

@implementation CreateUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 初始化对应的每个cell
-(void)loadCreateUserCell
{
    NSInteger index = self.tag;
    switch (index) {
        case 0:
            titleLab.text = @"手机号";
            contentField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
            contentField.userInteractionEnabled = NO;
            break;
        case 1:
            titleLab.text = @"设置密码";
            contentField.placeholder = @"6-16位数字和字母组合";
            break;
        case 2:
            titleLab.text = @"您的真名";
            contentField.placeholder = @"不超过6个字";
            break;
        case 3:
            titleLab.text = @"性别";
            contentField.hidden = YES;
            sexBg.hidden = NO;
            
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            titleLab.hidden = YES;
            contentField.hidden = YES;
            hLine.hidden = YES;
            float btW = [Util myXOrWidth:170];
            float btH = [Util myYOrHeight:40];
            UIButton *nextBt = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-btW)/2, (self.frame.size.height-btH)/2, btW, btH)];
            nextBt.backgroundColor = [UIColor lightGrayColor];
            [nextBt setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBt setTitleColor:Rgb(255, 149, 121,1.0) forState:UIControlStateNormal];
            [nextBt addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:nextBt];
            
        }
            break;
                default:
            break;
    }
    
}
#pragma mark - 下一步的触发事件
-(void)nextAction
{
    self.operateButton(3);
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.operateTextField(textField);
    return YES;
}
- (IBAction)setSexAction:(id)sender {
    UIButton_Custom *bt = (UIButton_Custom*)sender;
    NSInteger index = bt.tag;
    //取消键盘 存储数据
    self.operateButton(index);
    
    //将另外的按钮还原
    for (UIView *view in [sexBg subviews]) {
        if ([view isKindOfClass:[UIButton_Custom class]]&&view.tag != index) {
            UIButton_Custom *tempBt = (UIButton_Custom*)view
            ;
            tempBt.backgroundColor = [UIColor redColor];
        }
    }
    
    //修改界面
    if (bt.specialMark ==0) {//从未选中到选中状态
        bt.backgroundColor = [UIColor blueColor];
        bt.specialMark = 1;
        return;
    }else
    {//从选中到未选中状态
        bt.backgroundColor = [UIColor redColor];
        bt.specialMark = 0;
    }
    
}
@end

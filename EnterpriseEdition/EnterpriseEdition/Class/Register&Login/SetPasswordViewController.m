//
//  SetPasswordViewController.m
//  忘记密码中的设置密码
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()
{
    UITextField *currentTextField;
    UITapGestureRecognizer *cancelKeyTap;
    
    NSMutableArray *contentArray;
}
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认密码";
    self.view.backgroundColor = kCVBackgroundColor;
    
    dataTableViewToTop.constant = [Util myYOrHeight:30];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kRegisterAccount];
    contentArray = [[NSMutableArray alloc] initWithObjects:phone,@"",@"",@"",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"RegisterTableViewCellID";
    RegisterTableViewCell *cell = (RegisterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegisterTableViewCell" owner:self options:nil] lastObject];
    }
    cell.cellType = 2;
    cell.tag = indexPath.row;
    cell.delegate = self;
    [cell loadSubView:[contentArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return [Util myYOrHeight:80];
    }
    return [Util myYOrHeight:45];
}
#pragma mark - RegisterTableViewCellDelegate
-(void)setEditView:(UITextField*)_editView
{
    //编辑视图textField之间的切换时 会将前一个的内容保存
    [self editTextFiledAndCancelKey:NO];
    //最后一行的TextView与其他的TextField之间切换时 会将最后一行的内容保存
    currentTextField = _editView;
    if (cancelKeyTap==nil) {
        cancelKeyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
        [self.view addGestureRecognizer:cancelKeyTap];
    }
    
}
//点击界面上取消键盘
-(void)cancelKey
{
    //编辑视图textField在键盘取消时 会将内容保存
    [self editTextFiledAndCancelKey:YES];
    if (cancelKeyTap) {
        [self.view removeGestureRecognizer:cancelKeyTap];
        cancelKeyTap = nil;
    }
    
    currentTextField = nil;
    
}
-(void)editTextFiledAndCancelKey:(BOOL)isCancel
{
    if (isCancel) {
        [currentTextField resignFirstResponder];
    }
    if (currentTextField) {
        NSString *content = currentTextField.text;
        if ([content length]>0) {
            [contentArray replaceObjectAtIndex:currentTextField.tag withObject:content];
            //将需要注册的手机号码进行存储
            if (currentTextField.tag == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:currentTextField.text forKey:kRegisterAccount];
            }
        }else
        {
            [contentArray replaceObjectAtIndex:currentTextField.tag withObject:@"0"];
        }
    }
}
//确认提交
-(void)clickedNextBtAction
{
    [self editTextFiledAndCancelKey:NO];
    
    NSString *password = [contentArray objectAtIndex:1];
    if ([Util checkPassWord:password]) {//密码符合标准
        NSString *surePassword = [contentArray objectAtIndex:2];
        if ([surePassword length]>0) {
            if ([surePassword isEqualToString:password]) {//两次输入的密码一致 提交服务器修改
                NSLog(@"设置密码的内容填写正确，请求服务器修改");
            }else
            {
                [Util showPrompt:@"两次输入的密码不一致"];
            }
        }else
        {
            [Util showPrompt:@"请输入确认密码"];
        }
        
    }
    
}

@end

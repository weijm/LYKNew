//
//  ChangePasswordViewController.m
//  修改密码
//
//  Created by wjm on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ChangePasswordViewController.h"


@interface ChangePasswordViewController ()
{
    UITapGestureRecognizer *cancelKeyTap;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
    [self initItems];
    
    contentArray = [[NSMutableArray alloc] init];
    for (int i =0; i<3; i++) {
        [contentArray addObject:@"0"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
        
    
}
-(void)leftAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ChangePasswordTableViewCellID";
    ChangePasswordTableViewCell *cell = (ChangePasswordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChangePasswordTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    [cell loadTitlData];
    cell.delegate = self;
    
    [cell loadContent:[contentArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark -ChangePasswordTableViewCellDelegate

-(void)setEditView:(UIView*)_editView
{
    //编辑视图textField之间的切换时 会将前一个的内容保存
    [self editTextFiledAndCancelKey:NO];
    currentTextField = (UITextField*)_editView;
    
    if (cancelKeyTap==nil) {
        cancelKeyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
        [self.view addGestureRecognizer:cancelKeyTap];
    }
}
//取消键盘
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
    if ([currentTextField isKindOfClass:[UITextField class]]) {
        UITextField *tempView = currentTextField;
        if (isCancel) {
            [tempView resignFirstResponder];
        }
        NSString *content = tempView.text;
        if ([content length]>0) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content", nil];
            [contentArray replaceObjectAtIndex:tempView.tag withObject:dictionary];
        }
    }
}

- (IBAction)nextAction:(id)sender {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:currentTextField.text,@"content", nil];
    [contentArray replaceObjectAtIndex:currentTextField.tag withObject:dictionary];
    NSObject *obj = [contentArray objectAtIndex:0];
    //验证旧密码是否填写正确
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)obj;
        NSString *oldPassWord = [dic objectForKey:@"content"];
        if ([oldPassWord isEqualToString:@"123456aa"]) {//与旧密码对比 通过
            obj = [contentArray objectAtIndex:1];
            if ([obj isKindOfClass:[NSDictionary class]]) {//新填写的密码验证
                dic = (NSDictionary*)obj;
                NSString *newPassWord = [dic objectForKey:@"content"];
                if ([Util checkPassWord:newPassWord]) {//新密码填写正确
                    obj = [contentArray objectAtIndex:2];
                    if ([obj isKindOfClass:[NSDictionary class]]) {//确认密码 验证
                        dic = (NSDictionary*)obj;
                        NSString *reviewPassWord = [dic objectForKey:@"content"];
                        if ([reviewPassWord isEqualToString:newPassWord]) {//新密码和确认密码相同
                            //修改密码发送请求
                            
                            NSLog(@"修改密码成功");
                        }else
                        {
                            [self showPrompt:@"确认密码错误"];
                        }
                    }else
                    {
                        //未填写确认密码
                        [self showPrompt:@"请填写确认密码"];
                    }
                }
            }else
            {//未填写新密码
                [self showPrompt:@"请填写新密码"];
            }
        }else
        {
            [self showPrompt:@"旧密码不正确"];
        }
    }else
    {//未填写旧密码
        [self showPrompt:@"请填写旧密码"];
    }
}
-(void)showPrompt:(NSString*)promptString
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(promptString, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end

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
    self.view.backgroundColor = kCVBackgroundColor;
//    [self initItems];
    
    contentArray = [[NSMutableArray alloc] init];
    for (int i =0; i<3; i++) {
        [contentArray addObject:@""];
    }
    
    NSString *acount = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
    phoneLab.text = acount;
    if (kIphone5) {
        nextBtToLine.constant = nextBtToLine.constant+40;
        tableToBottom.constant = -50;
    }else if (kIphone4)
    {
        nextBtToLine.constant = nextBtToLine.constant+60;
        tableToBottom.constant = -90;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark - 编辑按钮
//-(void)initItems
//{
//    CGRect frame = CGRectMake(0, 0, 50, 30);
//    
//    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
//    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
//    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
//    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
//    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
//    self.navigationItem.leftBarButtonItem = leftItem;
//        
//    
//}
//-(void)leftAction
//{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
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
    if (currentTextField&&[currentTextField isKindOfClass:[UITextField class]]) {
        UITextField *tempView = currentTextField;
        if (isCancel) {
            [tempView resignFirstResponder];
        }
        NSString *content = tempView.text;
        if ([content length]>0) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content", nil];
            [contentArray replaceObjectAtIndex:tempView.tag withObject:dictionary];
        }else
        {
            [contentArray replaceObjectAtIndex:tempView.tag withObject:@"0"];
        }
    }
}

- (IBAction)nextAction:(id)sender {
    [self editTextFiledAndCancelKey:NO];
    NSObject *obj = [contentArray objectAtIndex:0];
    //验证旧密码是否填写正确
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)obj;
        NSString *oldPassWord = [dic objectForKey:@"content"];
        NSString *rightPsd = [[NSUserDefaults standardUserDefaults] objectForKey:KPassWord];
        if ([oldPassWord isEqualToString:rightPsd]) {//与旧密码对比 通过
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
                            [self requestChangePaw:oldPassWord New:newPassWord];
//                            [self performSelector:@selector(requestChangePaw) withObject:nil afterDelay:0.0];
                        }else
                        {
                            [Util showPrompt:@"两次输入的密码不一致"];
                        }
                    }else
                    {
                        //未填写确认密码
                        [Util showPrompt:@"请填写确认密码"];
                    }
                }
            }else
            {//未填写新密码
                [Util showPrompt:@"请填写新密码"];
            }
        }else
        {
            [Util showPrompt:@"旧密码不正确"];
        }
    }else
    {//未填写旧密码
        [Util showPrompt:@"请填写旧密码"];
    }
}

-(void)requestChangePaw:(NSString*)password New:(NSString*)newPsd
{
    [self showHUD:@"正在修改密码"];
    NSString *infoJson = [CombiningData changePassword:password NewPsd:newPsd];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
                //出现登录页面
                //退出登录
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOut object:@"1"];
                //清空本地缓存的数据
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:@"" forKey:kLoginOrExit];
                [userDefault setObject:@"" forKey:KPassWord];
                [userDefault setObject:@"" forKey:kUID];
                
                
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    }];
}

@end

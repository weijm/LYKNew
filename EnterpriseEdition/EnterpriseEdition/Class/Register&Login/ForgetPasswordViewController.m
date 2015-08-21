//
//  ForgetPasswordViewController.m
//  忘记密码
//
//  Created by wjm on 15/7/25.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SetPasswordViewController.h"

@interface ForgetPasswordViewController ()
{
    UITextField *currentTextField;
    UITapGestureRecognizer *cancelKeyTap;
    
    NSMutableArray *contentArray;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    self.view.backgroundColor = kCVBackgroundColor;
    
    dataTableViewToTop.constant = [Util myYOrHeight:35];
    
    contentArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kRegisterAccount];
    [self loadBottomLabText];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //将计时器停止
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CodeTimer" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -设置客服电话
-(void)loadBottomLabText
{
    NSString *string = bottomLab.text;
    NSRange range = [string rangeOfString:@"4008-907-977"];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:Rgb(2, 139, 230, 1.0)
     
                          range:range];
    bottomLab.attributedText = attributedStr;
    
    bottomLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeCall)];
    [bottomLab addGestureRecognizer:tap];
}
-(void)makeCall
{
    NSLog(@"拨打电话");
    
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"RegisterTableViewCellID";
    RegisterTableViewCell *cell = (RegisterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegisterTableViewCell" owner:self options:nil] lastObject];
    }
    cell.cellType = 1;
    cell.tag = indexPath.row;
    cell.delegate = self;
    [cell loadSubView:[contentArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return [Util myYOrHeight:80];
    }
    return [Util myYOrHeight:44];
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
            [contentArray replaceObjectAtIndex:currentTextField.tag withObject:@""];
            if (currentTextField.tag == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kRegisterAccount];
            }
        }
    }
}
//下一步
-(void)clickedNextBtAction
{
    [self editTextFiledAndCancelKey:NO];
    
    NSString *phone = [contentArray firstObject];
    if ([Util checkTelephone:phone]) {//手机号正确
        NSString *code = [contentArray objectAtIndex:1];
        if ([code length]>0) {//输入了验证码
            //存储账号
            [[NSUserDefaults standardUserDefaults] setObject:phone forKey:kAccount];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KPassWord];
            //手机号和验证码输入完毕 请求服务器
            NSLog(@"忘记密码信息填写完整 请求服务器");
            SetPasswordViewController *setPasswordVC = [[SetPasswordViewController alloc] init];
            setPasswordVC.verifyCode = code;
            [self.navigationController pushViewController:setPasswordVC animated:YES];
        }else
        {
            [Util showPrompt:@"验证码不能为空"];
        }
    }
    
}
-(void)getCode
{
    NSString *phone = [contentArray firstObject];
    [self showHUD:@"正在获取验证码"];
    NSString *getCodeJson = [CombiningData forgetPasswordSecurityCode:phone];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:getCodeJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"验证码发送成功"];
                
                //                 [[NSNotificationCenter defaultCenter] postNotificationName:@"StartCodeTimer" object:nil];
            }else
            {
                NSLog(@"result == %@",result);
                [self hideHUDFaild:[result objectForKey:@"message"]];
            }
        }else
        {
            [self hideHUD];
            [self showAlertView:@"服务器请求失败"];
        }
    }];
//    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:getCodeJson httpMethod:HttpMethodPost WithSSl:nil];
//    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
//        if (result!=nil) {
//            if ([[result objectForKey:@"result"] intValue]>0) {
//                [self hideHUDWithComplete:@"验证码发送成功"];
//                
////                 [[NSNotificationCenter defaultCenter] postNotificationName:@"StartCodeTimer" object:nil];
//            }else
//            {
//                NSLog(@"result == %@",result);
//                [self hideHUDFaild:[result objectForKey:@"message"]];
//            }
//        }else
//        {
//            [self hideHUD];
//            [self showAlertView:@"服务器请求失败"];
//        }
//        
//    };
    
    
}


@end

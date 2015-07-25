//
//  RegisterUserViewController.m
//  注册
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "RegisterUserViewController.h"

#import "LoginViewController.h"

@interface RegisterUserViewController ()
{
    UITextField *currentTextField;
    UITapGestureRecognizer *cancelKeyTap;
    NSMutableArray *contentArray;

}
@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注 册";
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
    //登录入口
    [self initItems];
    
    dataTableViewToTop.constant = [Util myYOrHeight:30];
    
    contentArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"RegisterTableViewCellID";
    RegisterTableViewCell *cell = (RegisterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegisterTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    cell.delegate = self;
    [cell loadSubView:[contentArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return [Util myYOrHeight:80];
    }
    return [Util myYOrHeight:45];
}

#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setTitle:@"登录" forState:UIControlStateNormal];
    rightBt.titleLabel.font = [UIFont systemFontOfSize:15];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+15, titleInsets.bottom, titleInsets.right-15);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightAction
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark - 查看协议
-(void)lookUpAgreement
{
    NSLog(@"查看协议");
}
#pragma mark - 下一步的触发事件
-(void)nextAction
{

}
#pragma mark - PositionTableViewCellDelegate
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
    NSString *content = currentTextField.text;
    if ([content length]>0) {
        [contentArray replaceObjectAtIndex:currentTextField.tag withObject:content];
    }

}

@end

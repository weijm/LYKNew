//
//  CreateUserViewController.m
//  设置密码
//
//  Created by wjm on 15/7/7.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CreateUserViewController.h"
#import "CreateUserTableViewCell.h"

@interface CreateUserViewController ()
{
    //当前编辑的textField
    UITextField *currentTextField;
}
@end

@implementation CreateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"创建账号";
    
    dataTableView.separatorColor = [UIColor clearColor];
    
    //取消键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyBoard)];
    [dataTableView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"CellReuseID";
    CreateUserTableViewCell *cell = (CreateUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CreateUserTableViewCell" owner:self options:nil] lastObject];
        cell.tag = indexPath.row;
        cell.operateButton = ^(NSInteger index){
            if (index == 3) {//下一步触发事件
                [self nextAction];
            }else
            {
                [self cancelKeyBoard];
            }
            
        };
        cell.operateTextField = ^(UITextField *textField){
            [self currentOperationTextField:textField];
        };
        
        [cell loadCreateUserCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Util myYOrHeight:60];
}
#pragma mark - 下一步的触发事件
-(void)nextAction
{
    NSLog(@"CreateUserViewController nextAction");
}
#pragma mark- 赋值当前编辑的textfield
- (void)currentOperationTextField:(UITextField*)textField
{
    currentTextField = textField;
}
#pragma mark - 取消键盘
-(void)cancelKeyBoard
{
    NSLog(@"cancelKeyBoard");
    [currentTextField resignFirstResponder];
}
@end

//
//  OpenPositionViewController.m
//  发布职位
//
//  Created by wjm on 15/7/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "OpenPositionViewController.h"


@interface OpenPositionViewController ()
{
    //标题数组
    NSArray *titleArray;
    //编辑的内容数组
    NSMutableArray *contentArray;
    //取消键盘的手势
    UITapGestureRecognizer *cancelKeyTap;
}
@end

@implementation OpenPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    if (_isEditAgain) {
        self.title = @"编辑职位";
    }else
    {
        self.title = @"发布职位";
        //导航条的颜色
        [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    }
    
    //初始化item
    [self initItems];
    
    titleArray = [NSArray arrayWithContentsOfFile:[Util getBundlePath:@"position.plist"]];
    contentArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[titleArray count]; i++) {
        [contentArray addObject:@"0"];
    }
    
    lineWidth.constant = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Items按钮
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
    return [titleArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"PositionCellId";
    PositionTableViewCell *cell = (PositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    [cell initData:[titleArray objectAtIndex:indexPath.row]];
    [cell loadContent:[contentArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==11) {
        return [Util myYOrHeight:100];
    }else
    {
        return [Util myYOrHeight:33];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0 ||indexPath.row!=3||indexPath.row!=6||indexPath.row!=10||indexPath.row!=11) {
        [dataTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //取消键盘
        [self cancelKey];
        
        CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
        int style = 0;
        int row;
        
        switch (indexPath.row) {//与pickerView中的内容对应
            case 1:
                row = 7;
                break;
            case 2:
                row = 0;
                break;
            case 4:
                row = 1;
                break;
            case 5:
                row =6;
                break;
            case 7:
                row =4;
                break;
            case 8:
                row = 2;
                break;
            case 9:
                row = 5;
                break;
            default:
                break;
        }
        
        
        if(row == 5)//地区
        {
            style = 2;
        }else if(row == 3||row==0||row==7)//专业 此处修改[self showConditions: Content:]随着修改
        {
            style = 1;
        }
        FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
        pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
            [self showConditions:index Content:dictionary];
        };
        if(row == 0)
        {
            pickerView.categoryType = 1;
        }
        [pickerView loadData:row];
        [pickerView showInView:self.view];
    }
   
}
#pragma mark -将pickerView上选中的内容显示到界面
-(void)showConditions:(int)row Content:(NSDictionary*)dictionary
{
    int index = 0;
    //从picker的row转换为tableView的index
    switch (row) {//与pickerView中的内容对应
        case  7:
            index =1;
            break;
        case 0:
            index = 2;
            break;
        case 1:
            index = 4;
            break;
        case 6:
            index =5;
            break;
        case 4:
            index = 7;
            break;
        case 2:
            index = 8;
            break;
        case 5:
            index = 9;
            break;
        default:
            break;
    }

    if (row == 5 || row == 3 || row ==0 ||row == 7) {//地区 此处可以查询对应的id
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *province = [dictionary objectForKey:@"province"];
        NSString *city = [dictionary objectForKey:@"city"];
        NSString *district = [dictionary objectForKey:@"district"];
        NSString *content;
        if ([province isEqualToString:city]) {
            content = [NSString stringWithFormat:@"%@ %@",province,district];
        }else
        {
            content = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
        }
        [dic setObject:content forKey:@"content"];
        [contentArray replaceObjectAtIndex:index withObject:dic];
    }else
    {//其他
        [contentArray replaceObjectAtIndex:index withObject:dictionary];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath , nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - PositionTableViewCellDelegate
-(void)setEditView:(UIView*)_editView
{
    //编辑视图textField之间的切换时 会将前一个的内容保存
    [self editTextFiledAndCancelKey:NO];
    //最后一行的TextView与其他的TextField之间切换时 会将最后一行的内容保存
    [self editTextViewAndCancelKey:NO];
    editView = _editView;
    if (cancelKeyTap==nil) {
        cancelKeyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
        [self.view addGestureRecognizer:cancelKeyTap];
    }

    //让编辑第10行和11行的时候 编辑框可见
    if(editView.tag == 10||editView.tag == 11)
    {
        if (dataTableViewToBottom.constant ==0) {
            [UIView animateWithDuration:0.5 animations:^{
                NSLog(@"dataTableViewToBottom.constant = 100");
                dataTableViewToBottom.constant = 200;
                dataTableViewToTop.constant = dataTableViewToTop.constant-200;
            }];
        }
    }else
    {//对于其他的编辑框还原dataTableView位置
        if (dataTableViewToBottom.constant !=0) {
            [UIView animateWithDuration:0.5 animations:^{
                dataTableViewToBottom.constant = 0;
                dataTableViewToTop.constant = dataTableViewToTop.constant+200;
            }];
        }
        
    }
    
    [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:editView.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//点击界面上取消键盘
-(void)cancelKey
{
    //编辑视图textField在键盘取消时 会将内容保存
    [self editTextFiledAndCancelKey:YES];
    
    //取消最后一行职位描述的时候 将内容保存
    [self editTextViewAndCancelKey:YES];
    
    if (cancelKeyTap) {
        [self.view removeGestureRecognizer:cancelKeyTap];
        cancelKeyTap = nil;
    }
    editView = nil;
    
    //还原dataTableView位置
    if (dataTableViewToBottom.constant !=0) {
        [UIView animateWithDuration:0.5 animations:^{
            dataTableViewToBottom.constant = 0;
            dataTableViewToTop.constant = dataTableViewToTop.constant+200;
        }];
    }
}
-(void)editTextFiledAndCancelKey:(BOOL)isCancel
{
    if ([editView isKindOfClass:[UITextField class]]) {
        UITextField *tempView = (UITextField*)editView;
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
-(void)editTextViewAndCancelKey:(BOOL)isCancel
{
    if ([editView isKindOfClass:[UITextView class]]) {
        UITextView *tempView = (UITextView*)editView;
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
#pragma mark - 将保存数据到本地
- (IBAction)saveDataAction:(id)sender {
    
}
#pragma mark - 提交审核发布的职位
- (IBAction)commitAction:(id)sender {
}
@end

//
//  CommendResumeViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendResumeViewController.h"
#import "CommendResumeTableViewCell.h"
#import "CommendResumeForJobViewController.h"

#define kCellHeight [Util myYOrHeight:60]
@interface CommendResumeViewController ()
{
    NSMutableArray *dataArray;
    
}
@end

@implementation CommendResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
    self.title = @"简历推荐";
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    //返回
    [self initItems];
    

    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"CommendResumeId";
    CommendResumeTableViewCell *cell = (CommendResumeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommendResumeTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    //查看简历
    CommendResumeForJobViewController *commendForJobVC = [[CommendResumeForJobViewController alloc] init];
    [self.navigationController pushViewController:commendForJobVC animated:YES];
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

@end

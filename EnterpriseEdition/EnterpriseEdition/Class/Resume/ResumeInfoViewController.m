//
//  ResumeInfoViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeInfoViewController.h"
#import "InfoHeaderView.h"
#import "IdentityTableViewCell.h"

@interface ResumeInfoViewController ()

@end

@implementation ResumeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"张晓晓";
    
    InfoHeaderView *headerView = [[InfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:180])];
    infoTableView.tableHeaderView = headerView;
    infoTableView.separatorColor = [UIColor clearColor];
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
        //导航栏下面是否显示内容
        [self.navigationController.navigationBar setTranslucent:YES];
        self.navigationController.navigationBar.shadowImage = [Util imageWithColor:[UIColor clearColor]];
    }];
 }

-(void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
       
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"ID";
    IdentityTableViewCell *cell = (IdentityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IdentityTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return [Util myYOrHeight:160];
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    return headerView;
//}
@end

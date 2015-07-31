//
//  MyInfoViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyTableViewCell0.h"
#import "MyTableViewCell1.h"
#import "MyTableViewCell2.h"
#import "VersionViewController.h"
#import "ChangePasswordViewController.h"
#import "InfoViewController.h"
#import "EnterpriseInfoViewController.h"



#define kFooterViewH kHeight -[Util myYOrHeight:78]-[Util myYOrHeight:87]-[Util myYOrHeight:37.5]*4-kFOOTERVIEWH-topBarheight

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = kCVBackgroundColor;
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
    if (indexPath.row == 0) {
        static NSString *cellid=@"MyTableViewCell0ID";
        MyTableViewCell0 *cell = (MyTableViewCell0 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell0" owner:self options:nil] lastObject];
        }
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        static NSString *cellid=@"MyTableViewCell1ID";
        MyTableViewCell1 *cell = (MyTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell1" owner:self options:nil] lastObject];
        }
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellid=@"MyTableViewCell2ID";
        MyTableViewCell2 *cell = (MyTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell2" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        [cell loadSubView];
        //取消点击cell选中效果
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [Util myYOrHeight:78];
    }else if (indexPath.row ==1)
    {
        return [Util myYOrHeight:87];
    }else
    {
        
        return [Util myYOrHeight:37.5];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kFooterViewH;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kFooterViewH)];
    footerView.userInteractionEnabled = YES;
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [Util myXOrWidth:100], [Util myYOrHeight:30])];
    bt.center = footerView.center;
    [bt setTitle:@"退出账号" forState:UIControlStateNormal];
    [bt setTitleColor:Rgb(0, 0, 0, 0.8) forState:UIControlStateNormal];
    if (kIphone6plus) {
        bt.titleLabel.font = [UIFont systemFontOfSize:15];
    }else
    {
        bt.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    [bt addTarget:self action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = Rgb(255, 255, 255, 1.0);
    bt.layer.borderWidth = 0.25;
    bt.layer.cornerRadius = 3;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.694, 0.694, 0.714, 1 });
    bt.layer.borderColor = colorref;
    [footerView addSubview:bt];
    return footerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        EnterpriseInfoViewController *enterpriseInfoVC = [[EnterpriseInfoViewController alloc] init];
        enterpriseInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:enterpriseInfoVC animated:YES];
    }
    else if (indexPath.row == 2) {
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else if (indexPath.row == 3) {
        VersionViewController *versionVC = [[VersionViewController alloc] init];
        versionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:versionVC animated:YES];
    }else if (indexPath.row == 5)
    {
        ChangePasswordViewController *changPVC = [[ChangePasswordViewController alloc] init];
        changPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changPVC animated:YES];
    }
}
-(void)exitApplication
{
    NSLog(@"退出账号");
}
@end

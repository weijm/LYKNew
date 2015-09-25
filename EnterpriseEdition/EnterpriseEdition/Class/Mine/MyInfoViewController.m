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
#import "MyCodeViewController.h"



#define kFooterViewH kHeight -[Util myYOrHeight:78]-[Util myYOrHeight:87]-[Util myYOrHeight:37.5]*5-kFOOTERVIEWH-topBarheight

@interface MyInfoViewController ()
{
    NSDictionary * resumeInfoDic;
    UIWebView *phoneWebView;
    NSString *newMsgCount;
}
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = kCVBackgroundColor;
    self.navigationItem.leftBarButtonItem = nil;
    
    if (kIphone4) {
        dataTableView.scrollEnabled = YES;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(requestMineInfo) withObject:nil afterDelay:0.0];
    [self performSelector:@selector(requestMsgCount) withObject:nil afterDelay:0.0];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellid=@"MyTableViewCell0ID";
        MyTableViewCell0 *cell = (MyTableViewCell0 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell0" owner:self options:nil] lastObject];
        }
        [cell loadSubView:resumeInfoDic];
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
        [cell loadsubView:resumeInfoDic];
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 7)
    {
        static NSString *cellId = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        UIView *tempView = [cell.contentView viewWithTag:10];
        if (tempView) {
            [tempView removeFromSuperview];
        }
        UIView *footerView = [self getFooterView];
        footerView.tag = 10;
        [cell.contentView addSubview:footerView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        static NSString *cellid=@"MyTableViewCell2ID";
        MyTableViewCell2 *cell = (MyTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell2" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        [cell loadSubView:newMsgCount];
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
    }
    else if (indexPath.row ==7)
    {
        if (kIphone4) {
            return kFooterViewH + [Util myYOrHeight:37.5];
        }
        return kFooterViewH;
    }
    else
    {
        
        return [Util myYOrHeight:37.5];
    }
}

-(UIView*)getFooterView
{
    float fH = kFooterViewH;
    if (kIphone4) {
        fH = kFooterViewH + [Util myYOrHeight:37.5];
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, fH)];
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
    
    bt.layer.borderColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.714 alpha:1.0].CGColor;
    [footerView addSubview:bt];
    return footerView;
    
}
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    float fH = kFooterViewH;
//
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, fH)];
//    footerView.userInteractionEnabled = YES;
//    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [Util myXOrWidth:100], [Util myYOrHeight:30])];
//    if (kIphone4) {
//        
//    }else
//    {
//        bt.center = footerView.center;
//    }
//    
//    [bt setTitle:@"退出账号" forState:UIControlStateNormal];
//    [bt setTitleColor:Rgb(0, 0, 0, 0.8) forState:UIControlStateNormal];
//    if (kIphone6plus) {
//        bt.titleLabel.font = [UIFont systemFontOfSize:15];
//    }else
//    {
//        bt.titleLabel.font = [UIFont systemFontOfSize:13];
//    }
//    
//    [bt addTarget:self action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
//    bt.backgroundColor = Rgb(255, 255, 255, 1.0);
//    bt.layer.borderWidth = 0.25;
//    bt.layer.cornerRadius = 3;
//   
//    bt.layer.borderColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.714 alpha:1.0].CGColor;
//    [footerView addSubview:bt];
//    footerView.backgroundColor = [UIColor redColor];
//    return footerView;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        EnterpriseInfoViewController *enterpriseInfoVC = [[EnterpriseInfoViewController alloc] init];
        enterpriseInfoVC.hidesBottomBarWhenPushed = YES;
        enterpriseInfoVC.entStatus = [[resumeInfoDic objectForKey:@"ent_status"] intValue];
        [self.navigationController pushViewController:enterpriseInfoVC animated:YES];
    }
    else if (indexPath.row == 2) {//我的二维码
        MyCodeViewController *codeVC = [[MyCodeViewController alloc] init];
        codeVC.infoDic = resumeInfoDic;
        codeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:codeVC animated:YES];
    }
    else if (indexPath.row == 3) {
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else if (indexPath.row == 4) {//版本说明
        VersionViewController *versionVC = [[VersionViewController alloc] init];
        versionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:versionVC animated:YES];
    }else if (indexPath.row == 6)//修改密码
    {
        ChangePasswordViewController *changPVC = [[ChangePasswordViewController alloc] init];
        changPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changPVC animated:YES];
    }else if (indexPath.row == 5)
    {
        //客服电话
        if ([Util checkDevice:@"iPod"]||[Util checkDevice:@"iPad"]){
            [Util showPrompt:@"该设备不支持打电话的功能"];
            return;
        }
        if (phoneWebView==nil) {
            phoneWebView = [[UIWebView alloc] init];
        }
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:4008907977"]];
        [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
   
}
-(void)exitApplication
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出该账号吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alterView show];
    
    
}
-(void)reloadView
{
    resumeInfoDic = nil;
    [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)requestMineInfo
{
   [self showHUD:@"正在加载数据"];
    NSString *infoJson = [CombiningData getMineInfo:kMineInfo];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                NSArray *dataArray = [result objectForKey:@"data"];
                if ([dataArray count]>0) {
                    resumeInfoDic = [dataArray firstObject];
                    [dataTableView reloadData];
                    [[NSUserDefaults standardUserDefaults] setObject:[Util getCorrectString:[resumeInfoDic objectForKey:@"ent_status"]] forKey:kEntStatus];
                }
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
                resumeInfoDic = nil;
                [dataTableView reloadData];
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    }];
}
-(void)requestMsgCount
{
    NSString *infoJson = [CombiningData getMineInfo:kMsgUnReadCount];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                NSArray *dataArray = [result objectForKey:@"data"];
                if ([dataArray count]>0) {
                    NSDictionary *dic = [dataArray firstObject];
                    newMsgCount = [dic objectForKey:@"new_total"];
                    if ([newMsgCount intValue]>0) {
                        //将消息数量显示到界面上
                        [self setMsgCountBadge];
                        [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }
        }else
        {
        }
    }];
}
#pragma mark - 退出确认
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        //退出登录
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOut object:@"1"];
        //清空本地缓存的数据
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:@"" forKey:kLoginOrExit];
        [userDefault setObject:@"" forKey:kUID];
        
        [self performSelector:@selector(reloadView) withObject:nil afterDelay:1.5];
    }
}
#pragma mark -下标的消息数
-(void)setMsgCountBadge
{
    self.tabBarItem.badgeValue = newMsgCount;
}
@end

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
#import "JobIntensionTableViewCell.h"
#import "EducationTableViewCell.h"
#import "HobbiesTableViewCell.h"
#import "ExperienceTableViewCell.h"
#import "CertificateTableViewCell.h"
#import "UIButton+Custom.h"

@interface ResumeInfoViewController ()
{
    BOOL showIndentityInfo;
    NSMutableArray *infoArray;
}
@end

@implementation ResumeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"张晓晓";
    lineWidth.constant = 0.5;
    showIndentityInfo = NO;
    infoTableView.separatorColor = [UIColor clearColor];
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    callBt.backgroundColor = Rgb(95, 182, 239, 1.0);
    colletedBt.backgroundColor =  Rgb(95, 182, 239, 1.0);
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
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0://身份信息
            cell = [self getIdentityCell:tableView];
            break;
        case 1://求职意向
            cell = [self getJobIntensionCell:tableView];
            break;
        case 2://教育背景
            cell = [self getEducationCell:tableView];
            break;
        case 3://特长/兴趣
        case 5://自我评价
        case 6://个人荣誉
            cell = [self getHobbiesCell:tableView];
            [(HobbiesTableViewCell*)cell loadContent:nil type:(int)indexPath.row];
            break;
        case 4://实习经验
            cell = [self getExperienceCell:tableView];
            [(ExperienceTableViewCell*)cell loadExperience:[NSArray arrayWithObjects:@"0",@"0", nil]];
            break;
        case 7://求职证书
            cell = [self getCertificateCell:tableView];
            [(CertificateTableViewCell*)cell loadCertificate:[NSArray arrayWithObjects:@"0",@"0", nil]];
            break;
        default:
            cell = [UITableViewCell new];
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellH = 44;
    switch (indexPath.row) {
        case 0://身份信息
        {
            if (showIndentityInfo) {
                cellH = [Util myYOrHeight:100];
            }else
            {
                cellH = [Util myYOrHeight:65];
            }
            
        }
            break;
        case 1://求职意向
            cellH = [Util myYOrHeight:120];
            break;
        case 2://教育背景
            cellH = 90;
            break;
        case 3://特长/兴趣
            cellH = 100;
            break;
        case 4://实习经验
            cellH = 310;
            break;
        case 5://自我评价
            cellH = 80;
            break;
        case 6://个人荣誉
            cellH = 60;
            break;
        case 7://求职证书
            cellH = 190;
            break;

            
        default:
            break;
    }
    
    return cellH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [Util myYOrHeight:180];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    InfoHeaderView *headerView = [[InfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:180])];
    return headerView;
}
#pragma mark - 不同cell的初始化
//身份信息cell
-(UITableViewCell*)getIdentityCell:(UITableView*)tableView
{
    static NSString *cell0=@"IdentityId";
    IdentityTableViewCell *cell = (IdentityTableViewCell *)[infoTableView dequeueReusableCellWithIdentifier:cell0];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IdentityTableViewCell" owner:self options:nil] lastObject];
        [cell showInfo:showIndentityInfo];
        cell.lookIdentityInfo = ^{
            [self lookIdentityInfo];
        };
    }
    
    return cell;
}
//求职意向cell
-(UITableViewCell*)getJobIntensionCell:(UITableView*)tableView
{
    static NSString *cell1=@"JobIntensionId";
    JobIntensionTableViewCell *cell = (JobIntensionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell1];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobIntensionTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
//教育背景cell
-(UITableViewCell*)getEducationCell:(UITableView*)tableView
{
    static NSString *cell2=@"EducationId";
    EducationTableViewCell *cell = (EducationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell2];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EducationTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
//兴趣爱好 自我评价 个人荣誉cell
-(UITableViewCell*)getHobbiesCell:(UITableView*)tableView
{
    static NSString *cell3=@"HobbiesId";
    HobbiesTableViewCell *cell = (HobbiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell3];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HobbiesTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

//实习经验Cell
-(UITableViewCell*)getExperienceCell:(UITableView*)tableView
{
    static NSString *cell4=@"ExperienceId";
    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell4];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExperienceTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
//求职证书Cell
-(UITableViewCell*)getCertificateCell:(UITableView*)tableView
{
    static NSString *cell5=@"CertificateId";
    CertificateTableViewCell *cell = (CertificateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell5];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CertificateTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
#pragma mark - 查看身份信息详情
-(void)lookIdentityInfo
{
    showIndentityInfo = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark - 点击事件
- (IBAction)makeCall:(id)sender {
    //客服电话
    if ([Util checkDevice:@"iPod"]||[Util checkDevice:@"iPad"]){
        [Util showPrompt:@"该设备不支持打电话的功能"];
        return;
    }
    NSURL *phoneNumberURL = [NSURL URLWithString:@"tel:4008907977"];//客服电话
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}

- (IBAction)collectedAction:(id)sender {
    UIButton_Custom *button = (UIButton_Custom*)sender;
    if (button.specialMark ==0) {
        button.specialMark = 1;
        button.backgroundColor = Rgb(227, 227, 231, 1.0);
        [button setTitle:@"取消收藏" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else
    {
        button.specialMark = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = Rgb(95, 182, 239, 1.0);
        [button setTitle:@"收    藏" forState:UIControlStateNormal];
    }
    
}
@end

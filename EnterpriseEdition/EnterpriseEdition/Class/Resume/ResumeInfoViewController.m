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

#define MAXFLOAT [Util myYOrHeight:200]

@interface ResumeInfoViewController ()
{
    BOOL showIndentityInfo;
    NSMutableArray *infoArray;
    
    InfoHeaderView * headerView;
    
    NSString *contactPhone;
    NSString *downloadCount;
}
@end

@implementation ResumeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"简历详情";
    lineWidth.constant = 0.5;
    showIndentityInfo = NO;
    infoTableView.separatorColor = [UIColor clearColor];
    
    callBt.backgroundColor = Rgb(95, 182, 239, 1.0);
    colletedBt.backgroundColor =  Rgb(95, 182, 239, 1.0);
    
    infoArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [self performSelector:@selector(requestResumeInfo) withObject:nil afterDelay:0.0];
    
    [self initHeaderView];
    
    if (_fromCollected) {
        colletedBt.specialMark = 0;
    }else
    {
        colletedBt.specialMark = 1;
    }
    [self loadCollectedBtState:colletedBt];
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
            cell = [self getIdentityCell:tableView Index:indexPath];
            break;
        case 1://求职意向
            cell = [self getJobIntensionCell:tableView Index:indexPath];
            break;
        case 2://教育背景
            cell = [self getEducationCell:tableView Index:indexPath];
            break;
        case 3://特长/兴趣
        case 5://自我评价
        case 6://个人荣誉
            cell = [self getHobbiesCell:tableView Index:indexPath];
            
            break;
        case 4://实习经验
            cell = [self getExperienceCell:tableView Index:indexPath];
            
            break;
        case 7://求职证书
            cell = [self getCertificateCell:tableView Index:indexPath];
            
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
        {
            NSObject *obj = [infoArray objectAtIndex:indexPath.row];
            if ([obj isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = (NSArray*)obj;
                return [dataArray count]*80;
            }
            
            cellH = [Util myYOrHeight:40];
       
        }
            
            break;
        case 3://特长/兴趣
        case 5://自我评价
        case 6://个人荣誉
        {
            NSString *key = @"interest";
            if (indexPath.row == 5) {
                key = @"self_appraisal";
            }else if (indexPath.row == 6)
            {
                key = @"reward";
            }
            NSObject *object = [infoArray objectAtIndex:indexPath.row];
            if ([object isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = (NSArray*)object;
                if ([dataArray count]>0) {
                    NSDictionary *dic = [dataArray firstObject];
                    
                    NSString *contentString = [[dic objectForKey:key] stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
                    int row = [Util getRow:(int)[contentString length] eachCount:[self getEachLength:(int)index]];
                    if ([contentString length]==0||row==1) {
                        return [Util myYOrHeight: 40];
                    }
                    CGSize titleSize = [contentString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake([Util myXOrWidth:160], MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                    return titleSize.height;

                }
            }
            return [Util myYOrHeight: 40];
       
        }
            break;
        case 4://实习经验
        {
            return [self getExperienceHeight:4];
       
        }
            break;
        case 7://求职证书
            return [self getCerHeight:7];
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
    
    return headerView;
}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    headerView = [[InfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:180])];
}
#pragma mark - 不同cell的初始化
//身份信息cell
-(UITableViewCell*)getIdentityCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
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
    if (showIndentityInfo) {
        [cell loadData:[self getFirstObject]];
    }else
    {
        [cell loadRetaimCount:downloadCount];
    }
    return cell;
}
//求职意向cell
-(UITableViewCell*)getJobIntensionCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell1=@"JobIntensionId";
    JobIntensionTableViewCell *cell = (JobIntensionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell1];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobIntensionTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadData:[infoArray objectAtIndex:indexPath.row]];
    return cell;
}
//教育背景cell
-(UITableViewCell*)getEducationCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell2=@"EducationId";
    EducationTableViewCell *cell = (EducationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell2];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EducationTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadData:[infoArray objectAtIndex:indexPath.row]];
    return cell;
}
//兴趣爱好 自我评价 个人荣誉cell
-(UITableViewCell*)getHobbiesCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell3=@"HobbiesId";
    HobbiesTableViewCell *cell = (HobbiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell3];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HobbiesTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadContent:[infoArray objectAtIndex:indexPath.row] type:(int)indexPath.row];
    return cell;
}

//实习经验Cell
-(UITableViewCell*)getExperienceCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell4=@"ExperienceId";
    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell4];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExperienceTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadExperience:[infoArray objectAtIndex:indexPath.row]];
    return cell;
}
//求职证书Cell
-(UITableViewCell*)getCertificateCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell5=@"CertificateId";
    CertificateTableViewCell *cell = (CertificateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell5];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CertificateTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadCertificate:[infoArray objectAtIndex:indexPath.row]];
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
    if ([contactPhone length]>0) {
        NSString *telPhone = [NSString stringWithFormat:@"tel:%@",contactPhone];
        NSURL *phoneNumberURL = [NSURL URLWithString:telPhone];//联系电话电话
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
    }
    
}

- (IBAction)collectedAction:(id)sender {
    UIButton_Custom *button = (UIButton_Custom*)sender;
    [self loadCollectedBtState:button];
}
-(void)loadCollectedBtState:(UIButton_Custom*)button
{
    if (button.specialMark ==0) {
        button.specialMark = 1;
        button.backgroundColor = Rgb(227, 227, 231, 1.0);
        [button setTitle:@"取消收藏" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //通知服务器添加收藏
        [self requesBatchDealWithResumeType:1];
    }else
    {
        button.specialMark = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = Rgb(95, 182, 239, 1.0);
        [button setTitle:@"收    藏" forState:UIControlStateNormal];
        //通知服务器取消收藏
        [self requesBatchDealWithResumeType:2];

    }
    
}
#pragma mark - 请求服务器的数据
-(void)requestResumeInfo
{
    [self showHUD:@"加载数据中"];
    NSArray *typeArray = [NSArray arrayWithObjects:kResumeBaseInfo,kResumeJobObjective,kResumeDegreeList,kResumeInterest,kResumeInternships,kResumeAppraisal,kResumeReward,kResumeCertify,kResumeDownloadCount,kResumeStatus, nil];
    NSInteger requestCount = [typeArray count];
    __block int responeCount = 0;
    for (int i = 0; i < requestCount; i++) {
        NSString *typeString = [typeArray objectAtIndex:i];
        NSString *key = @"rid";
        NSString *value = [NSString stringWithFormat:@"%d",_resumeID];

        NSString *jsonString = [CombiningData getResumeInfo:typeString keyString:key Value:value];
        //请求服务器
        [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost WithSSl:nil];
        [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
            //请求次数
            responeCount++;
            //如果请求次数与typeArray个数相同 取消缓冲页面
            if (responeCount == [typeArray count]) {
                [self hideHUD];
            }
            if (result!=nil) {
                if ([[result objectForKey:@"result"] intValue]>0) {
                    NSDictionary *resultDic = [Util dictionaryWithJsonString:[result objectForKey:@"requestJson"]];
                    NSString *responType = [resultDic objectForKey:@"type"];
                    if ([responType isEqualToString:kResumeDownloadCount]) {
                        NSArray *tempArr = [result objectForKey:@"data"];
                        if ([tempArr count]>0) {
                            downloadCount = [[tempArr firstObject] objectForKey:@"count"];
                            [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                        }
                        
                    }else if ([responType isEqualToString:kResumeStatus])
                    {
                        NSArray *tempArr = [result objectForKey:@"data"];
                        if ([tempArr count]>0) {
                            NSDictionary *statuDic = [tempArr firstObject];
                            [headerView loadStatus:statuDic];
                        }
                    }else
                    {
                         [self dealWithInfo:result Type:typeArray];
                    }
                   
                    
                }else
                {
                    //请求的数据有问题
//                    NSLog(@"result == %@",result);
                }
            }
        };
    }
}
-(void)dealWithInfo:(id)responObj Type:(NSArray*)typeArray
{
    NSString *requestJson = [responObj objectForKey:@"requestJson"];
    NSDictionary *jsonDic = [Util dictionaryWithJsonString:requestJson];
    NSString *typeString = [jsonDic objectForKey:@"type"];//
    NSInteger index = [typeArray indexOfObject:typeString];
    //数组里面的第几个
    NSArray *dataArray = [responObj objectForKey:@"data"];
    if ([dataArray count]>0) {
        [infoArray replaceObjectAtIndex:index withObject:dataArray];
        [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        //刷新headerView 和标题
        if (index ==0) {
            [self getFirstObject];
        }
    }
    
    
   
}
#pragma mark - 收藏和取消收藏
#pragma mark - 批量编辑简历
-(void)requesBatchDealWithResumeType:(int)type
{
    [self showHUD:@"正在处理数据"];
    NSString *infoJson = [CombiningData batchManagerResume:[NSString stringWithFormat:@"%d",_resumeID] Status:type];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"数据处理成功"];
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"处理失败";
                }
                [self hideHUDFaild:message];
                NSLog(@"error message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
        
    };
    
}

#pragma mark- 每行文本显示的字数
-(int)getEachLength:(int)index
{
    if (index == 4) {
        if (kIphone4||kIphone5) {
            return 18;
        }else
            return 22;
    }else
    {
        if (kIphone4||kIphone5) {
            return 13;
        }else
            return 18;
    }
}
#pragma mark - 动态计算经验cell的高度
-(float)getExperienceHeight:(NSInteger)index
{
    float viewHeight =0;
    NSObject *obj = [infoArray objectAtIndex:index];
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)obj;
        float sizeX = [Util myXOrWidth:160];
        
        if (kIphone4||kIphone5) {
            sizeX = 250;
        }
        if ([array count]>0) {
            for (int i = 0; i < [array count]; i++)
            {
                NSDictionary *dic = [array objectAtIndex:i];
                NSString *content = [[dic objectForKey:@"job_description"] stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
                CGSize titleSize = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(sizeX, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
                float height = titleSize.height+[Util myYOrHeight:80];
                int row = [Util getRow:(int)[content length] eachCount:[self getEachLength:(int)index]];
//                float
                if (row ==1) {
                    height = [Util myYOrHeight:80]+row*19;
                }
                viewHeight = viewHeight+height;
                
            }
        }else
        {
            viewHeight = [Util myYOrHeight:40];
        }
    }else
    {
        viewHeight = [Util myYOrHeight:40];
    }
    return viewHeight;
}
#pragma mark - 动态计算证书cell的高度
-(float)getCerHeight:(NSInteger)index
{
    float cellHeight = 0;
    NSObject *obj = [infoArray objectAtIndex:index];
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)obj;
        NSInteger count = [array count];
        if (count>0) {
            for (int i = 0; i < count; i++)
            {
                NSDictionary *dic = [array objectAtIndex:i];
                float height = [Util myYOrHeight:40];
                if ([[dic objectForKey:@"certify_url"] length]>0) {
                    height = 100;
                }
                cellHeight = cellHeight+height;
            }
        }else
        {
            cellHeight = [Util myYOrHeight:40];
        }
    }else
    {
        cellHeight = [Util myYOrHeight:40];
    }

    return cellHeight;
}
#pragma mark - 获取第一个数据
-(NSDictionary*)getFirstObject
{
    NSDictionary *dictionary = nil;
    NSObject *obj = [infoArray firstObject];
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)obj;
        if ([array count]>0) {
            dictionary = [array firstObject];
            self.title = [dictionary objectForKey:@"name"];
            [headerView loadData:dictionary];
            contactPhone = [dictionary objectForKey:@"contact_no"];
        }
    }
    return dictionary;
}
@end

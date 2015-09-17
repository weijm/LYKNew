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
#import "FirstInfoTableViewCell.h"
#import "ScanCodeViewController.h"

//#define MAXFLOATCUSTOM [Util myYOrHeight:400]

@interface ResumeInfoViewController ()
{
    BOOL showIndentityInfo;
    NSMutableArray *infoArray;
    
    InfoHeaderView * headerView;
    
    NSDictionary *statusDic;
    
    NSString *contactPhone;
    NSString *downloadCount;
    
    UIWebView *phoneWebView;
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
    [self loadCollectedBtState:colletedBt isRequest:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [Util imageWithColor:[UIColor clearColor]];
 }

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];

}
-(void)leftAction
{
    NSArray *array = self.navigationController.viewControllers;
    for (int i =0; i< [array count]; i++) {
        UIViewController *vc = [array objectAtIndex:i];
        if ([vc isKindOfClass:[ScanCodeViewController class]]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if (i==[array count]-1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
                    NSString *tempStr = [Util getCorrectString:[dic objectForKey:key]];
                    NSString *contentString = [tempStr stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
                    int row = [Util getRow:(int)[contentString length] eachCount:[self getEachLength:(int)index]];
                    if ([contentString length]==0||row==1) {
                        return [Util myYOrHeight: 40];
                    }
                    CGSize textSize = [contentString sizeWithFont:[UIFont systemFontOfSize:[self getLabFont]] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
                    if (textSize.height < [self getLabHeight]) {
                        return [self getLabHeight];
                    }
                    return textSize.height;

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
    headerView.internships = _internships;
}
#pragma mark - 不同cell的初始化
//身份信息cell
-(UITableViewCell*)getIdentityCell:(UITableView*)tableView Index:(NSIndexPath *)indexPath
{
    static NSString *cell0=@"FirstInfoTableViewCellID";
    FirstInfoTableViewCell *cell = (FirstInfoTableViewCell *)[infoTableView dequeueReusableCellWithIdentifier:cell0];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstInfoTableViewCell" owner:self options:nil] lastObject];
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
    if (downloadCount<=0) {
        return;
    }
    showIndentityInfo = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
    //请求接口信息
    [self requestDownloadCount];
    
}

#pragma mark - 点击事件
- (IBAction)makeCall:(id)sender {
    if ([[statusDic objectForKey:@"download"] intValue]==0) {
        [Util showPrompt:@"对不起，您还未下载该简历"];
        return;
    }
    //客服电话
    if ([Util checkDevice:@"iPod"]||[Util checkDevice:@"iPad"]){
        [Util showPrompt:@"该设备不支持打电话的功能"];
        return;
    }
    if ([contactPhone length]>0) {
        if (phoneWebView==nil) {
            phoneWebView = [[UIWebView alloc] init];
        }
        NSString *telPhone = [NSString stringWithFormat:@"tel:%@",contactPhone];
        NSURL *url = [NSURL URLWithString:telPhone];
        [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
}

- (IBAction)collectedAction:(id)sender {
    UIButton_Custom *button = (UIButton_Custom*)sender;
    [self loadCollectedBtState:button isRequest:YES];
}
-(void)loadCollectedBtState:(UIButton_Custom*)button isRequest:(BOOL)isRequest
{
    if (button.specialMark ==0) {
        button.specialMark = 1;
        button.backgroundColor = Rgb(227, 227, 231, 1.0);
        [button setTitle:@"取消收藏" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //通知服务器添加收藏
        if (isRequest) {
            [self requesBatchDealWithResumeType:1];
        }
        
    }else
    {
        button.specialMark = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = Rgb(95, 182, 239, 1.0);
        [button setTitle:@"收    藏" forState:UIControlStateNormal];
        //通知服务器取消收藏
        if (isRequest) {
            [self requesBatchDealWithResumeType:2];
        }
        

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
        NSString *value = [NSString stringWithFormat:@"%@",_resumeID];
        NSString *jsonString = [CombiningData getResumeInfo:typeString keyString:key Value:value];
        //请求服务器
        [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
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
                            statusDic = [NSDictionary dictionaryWithDictionary:statuDic];
                            [headerView loadStatus:statuDic];
                            //如果已经收藏的简历 显示的是取消收藏
                            if ([[statuDic objectForKey:@"favorite"] intValue]==1) {
                                colletedBt.specialMark = 0;
                            }else
                            {
                                colletedBt.specialMark = 1;
                            }
                            [self loadCollectedBtState:colletedBt isRequest:NO];
                            if ([[statuDic objectForKey:@"download"] intValue]==1) {
                                showIndentityInfo = YES;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                            }
                        }
                    }else
                    {
                        [self dealWithInfo:result Type:typeArray];
                    }
                }else
                {
                    //请求的数据有问题
                }
            }else
            {
                NSLog(@"result == %@",result);
                
            }

        }];
    }
}
-(void)dealWithInfo:(id)responObj Type:(NSArray*)typeArray
{
    NSString *requestJson = [responObj objectForKey:@"requestJson"];
    NSDictionary *jsonDic = [Util dictionaryWithJsonString:requestJson];
    NSString *typeString = [jsonDic objectForKey:@"type"];//
    NSInteger index = [typeArray indexOfObject:typeString];
    if (index>7||index<0) {
        return;
    }
    //数组里面的第几个
    NSArray *dataArray = [responObj objectForKey:@"data"];
    if (dataArray!=nil &&[dataArray count]>0) {
        [infoArray replaceObjectAtIndex:index withObject:dataArray];
        [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        //刷新headerView 和标题
        if (index ==0) {
            [self getFirstObject];
        }
    }
    
    
   
}
#pragma mark - 收藏和取消收藏
-(void)requesBatchDealWithResumeType:(int)type
{
    [self showHUD:@"正在处理数据"];
    NSString *infoJson = [CombiningData batchManagerResume:[NSString stringWithFormat:@"%@",_resumeID] Status:type];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self batchDataPrompt:result Success:YES];
            }else
            {
               [self batchDataPrompt:result Success:NO];
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    }];
    
}
#pragma mark - 点击查看联系方式通知服务器请求
-(void)requestDownloadCount
{
    NSString *infoJson = [CombiningData getLookContact:_jobID ResumeId:[NSString stringWithFormat:@"%@",_resumeID]];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
            }else
            {
            }
        }else
        {
        }
    }];

}
#pragma mark - 收藏或取消收藏的提示
-(void)batchDataPrompt:(id)result Success:(BOOL)isSuccess
{
    NSString *statusString = [result objectForKey:@"requestJson"];
    NSDictionary *dic = [Util dictionaryWithJsonString:statusString];
    int status = [[dic objectForKey:@"action_type"] intValue];
    if (isSuccess) {
        if (status == 1) {//收藏成功
            [self hideHUDWithComplete:@"收藏成功"];
        }else if (status == 2)//取消收藏
        {
            [self hideHUDWithComplete:@"取消收藏成功"];
        }
    }else
    {
        if (status == 1) {//收藏成功
            [self hideHUDFaild:@"收藏失败"];
        }else if (status == 2)//取消收藏
        {
            [self hideHUDFaild:@"取消收藏失败"];
        }
    }
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
    int row1Count = 0;
    float row1Height = [Util myYOrHeight:105];
    float onlyOnewHeight = [Util myYOrHeight:80];
    float edgeHeight = 232;
    float textHeigt = [Util myYOrHeight:45];
    float onetextHeigt = [Util myYOrHeight:70];
    float fontSize = 19;
    
    if (kIphone5||kIphone4) {
        row1Height = 110;
        onlyOnewHeight = 100;
        edgeHeight = 186;
        onetextHeigt = 80;
        textHeigt = 70;
    }else
    {
        fontSize = 21;
        onlyOnewHeight = [Util myYOrHeight:85];
    }
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
                NSString *content = [[dic objectForKey:@"job_description"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                CGSize titleSize = [content sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake([self getExeLabWidth], MAXFLOAT)];
                float height1 = titleSize.height+textHeigt;
                if ([array count]==1) {
                    height1 = titleSize.height+onetextHeigt;
                }
                
                if (titleSize.height>=edgeHeight&&[array count]==1) {
                    height1 = titleSize.height+onlyOnewHeight;
                }
                int row = [Util getRow:(int)[content length] eachCount:[self getEachLength:(int)index]];
                if (row ==1) {
                    
                    row1Count++;
                    if (row1Count>=2) {
                        height1 =row1Height +row*fontSize;
                    }else
                    {
                        height1 =onlyOnewHeight +row*fontSize;
                    }
                    
                }
                
                NSString *imgUrl = [Util getCorrectString:[dic objectForKey:@"certify_url"]];
                if ([imgUrl length]>0) {//有图片
                    height1 = height1+60;
                }
                
                viewHeight = viewHeight+height1;
                
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
                    height = 95 ;
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
#pragma mark - 兴趣 特长 自我评价 个人荣誉的lab宽度
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 300;
    }else if (kIphone6)
    {
        return 277;
    }else
    {
        return 222;
    }
}
-(float)getLabFont
{
    if (kIphone5||kIphone4) {
        return 17;
    }else
    {
        return 16;
    }
}
-(float)getLabHeight
{
    if (kIphone6plus) {
        return 120;
    }else if(kIphone6)
    {
        return [Util myYOrHeight: 40];
    }else
    {
        return 60;
    }
    
}

#pragma mark -工作经验内容的lab宽度
-(float)getExeLabWidth
{
    if (kIphone6plus) {
        return 290;
    }else if (kIphone6)
    {
        return 250;
    }else
    {
        return 222;
    }
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
            NSString *titleString = [dictionary objectForKey:@"name"];
            if ([titleString length]>8) {//如果名字长度大于8 自动截取
                titleString = [titleString substringToIndex:8];
            }
            self.title = titleString;
            [headerView loadData:dictionary];
            contactPhone = [dictionary objectForKey:@"contact_no"];
        }
    }
    return dictionary;
}
@end

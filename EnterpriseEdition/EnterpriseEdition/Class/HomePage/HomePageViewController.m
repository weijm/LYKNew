//
//  HomePageViewController.m
//  app首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "CommendView.h"
#import "SearchResumeViewController.h"//搜索
#import "NowHiringViewController.h"//急招
#import "CommendResumeViewController.h"//简历推荐
#import "OpenPositionViewController.h" //发布职位
#import "LoginViewController.h"
#import "HireOfView.h"
#import "ResumeInfoViewController.h"

#import "LocationViewController.h"

#define kBannerViewHeight [Util myYOrHeight:180]
#define kHireViewHeight [Util myYOrHeight:174]
@interface HomePageViewController ()
{
    //横向滚动视图
    BannerView *bannerView;
    //banner数组
    NSArray *bannerArray;
    
    //应聘部分的视图
    HireOfView *hireOfView;
    //推荐部分的视图
    CommendView *commendView;
    
    //应聘数组
    NSArray *hireArray;

    //推荐数组
    NSArray *commendArray;
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [Util imageWithColor:[UIColor clearColor]];
    
    //初始化item
    [self initItems];

    contentTableView.separatorColor = [UIColor clearColor];

    //ios7以上的版本滚动视图自动产生竖向偏移
    if (kDeviceVersion>=7.0 &&[self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:Rgb(230, 230, 230,0.0)] forBarMetrics:UIBarMetricsDefault];
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    int isLogin = [[userDefault objectForKey:kLoginOrExit] intValue];
    if (isLogin>0) {
        [self performSelector:@selector(requestInfoFromWeb) withObject:nil afterDelay:0.0];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            [self initBannerView:cell.contentView];
        }else if (indexPath.row == 1)
        {
            [self initHireView:cell.contentView];
        }else
        {
            [self initCommendView:cell.contentView];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float hireH = kHireViewHeight;
    if (indexPath.row == 0) {
        if(kIphone4)
        {
            return 150;
        }
        return kBannerViewHeight;
    }else if(indexPath.row == 1)
    {
        return kHireViewHeight;
    }else
    {
        if (kIphone4) {
            
            return kHeight -150-hireH+40;
        }else if (kIphone5)
        {
            return kHeight -kBannerViewHeight-hireH;
        }
        return kHeight -kBannerViewHeight-hireH-[Util myYOrHeight:45];
    }
}

#pragma mark -bannerView 初始化
-(void)initBannerView:(UIView*)view
{
    CGRect frame;
    if (kIphone4) {
        frame = CGRectMake(0, 0, kWidth, 150);
    }else
    {
        frame = CGRectMake(0, 0, kWidth, kBannerViewHeight);
    }
    bannerView = [[BannerView alloc] initWithFrame:frame];
    __weak HomePageViewController *wself = self ;
    bannerView.clickedBannerAction = ^(int index){
        HomePageViewController *sself = wself;
        [sself clickedBannerAction:index];
    };
//    [bannerView loadBannerImage:[NSArray arrayWithObjects:@"11",@"11",@"11", nil]];
    [view addSubview:bannerView];
}
-(void)clickedBannerAction:(int)index
{
    if ([bannerArray count]>0) {
        NSDictionary *dic = [bannerArray objectAtIndex:index];
        if ([[dic objectForKey:@"jump_type"] intValue]==1) {
            NSLog(@"index == %d",index);
            NSString *source = [dic objectForKey:@"source"];
            NSLog(@"source== %@",source);
        }
    }
}

#pragma mark - navigation上的左右按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UILabel *titleLab= [[UILabel alloc] initWithFrame:frame];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"E朝朝企业版";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0];
    
    self.navigationItem.titleView = titleLab;
    
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"home_search_btn"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-20, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark -- item Action
-(void)leftAction
{
    NSLog(@"leftAction");
    SearchResumeViewController *searchVC = [[SearchResumeViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
#pragma mark - 初始化应聘部分的视图
-(void)initHireView:(UIView*)view
{
    CGRect frame = CGRectMake(0, 0, kWidth,kHireViewHeight );
//    hireView = [[HireView alloc] initWithFrame:frame];
    hireOfView = [[HireOfView alloc] initWithFrame:frame];
    //假数据
    NSArray *array = [self getHireData:nil];//[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"职位 10个",@"string",@"10个",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"急招 剩余12时",@"string",@"剩余12时",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已下载 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已收到 100份",@"string",@"100份",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"发布职位",@"string",@"",@"substring", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"收藏 100份",@"string",@"100份",@"substring", nil], nil];
    
    [hireOfView loadItem:array];
    //点击事件的触发
    __weak HomePageViewController *wSelf = self;
    hireOfView.clickedHire = ^(int index){
        HomePageViewController *sSelf = wSelf;
        [sSelf hireAction:index];
    };
    [view addSubview:hireOfView];
}
#pragma mark - 初始化推荐部分的视图
- (void)initCommendView:(UIView*)view
{
    float hireH = kHireViewHeight;
    float commendViewH = kHeight - kBannerViewHeight-hireH - [Util myYOrHeight:45];
    if (kIphone4) {
        commendViewH = kHeight - 150-hireH ;
    }
    CGRect frame = CGRectMake(0, 0, kWidth, commendViewH);
    //假数据
    NSArray *dataArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"UI设计师",@"job",@"王伟",@"name",@"艺术设计",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"ios开发师",@"job",@"赵倩",@"name",@"计算机专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"java开发",@"job",@"王东志",@"name",@"软件工程",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"web开发",@"job",@"刘一民",@"name",@"数学专业",@"pro", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"前段设计",@"job",@"李浩",@"name",@"外语专业",@"pro", nil], nil];
    
    commendView = [[CommendView alloc] initWithFrame:frame];
    NSString * iid = KGETOBJ(KIID);
    if ([iid intValue]>0) {
        [commendView loadSubView:dataArray];
    }else
    {
        [commendView loadSubView:nil];
    }
    
    //点击某个人的触发事件
    
    __weak HomePageViewController *wSelf = self;
    commendView.clickPersonalInfo = ^(NSInteger index){
        HomePageViewController *sself = wSelf;
        [sself lookupPersonalResume:index];
    };
    [view addSubview:commendView];
}

#pragma mark - 点击应聘部分的按钮的相应触发事件
-(void)hireAction:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"职位");
        {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"20"];
        }
            break;
        case 1:
        {
            NSString * iid = KGETOBJ(KIID);
            if ([iid intValue]<1) {
                [Util showPrompt:@"当前您没有急招职位"];
                return;
            }
            NowHiringViewController *nowhiringVC = [[NowHiringViewController alloc] init];
            nowhiringVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nowhiringVC animated:YES];

        }
            break;
        case 2:
            NSLog(@"已下载");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"13"];
        }
            break;
        case 3:
            NSLog(@"已收到");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"11"];
        }
            break;
        case 4:
        {
            NSString * iid = KGETOBJ(KIID);
            if ([iid intValue]<1) {
                [Util showPrompt:@"您还未提交资料审核，暂不能发布职位"];
                return;
            }
            OpenPositionViewController *openpVC = [[OpenPositionViewController alloc] init];
            openpVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:openpVC animated:YES];
        }
            break;
        case 5:
            NSLog(@"收藏");
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedVC" object:@"12"];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 查看简历
-(void)lookupPersonalResume:(NSInteger) index
{
    if (index == 100) {
        NSLog(@"查看更多推荐简历");
        if (![self getEnterpriseCheckState]) {
            return;
        }
        CommendResumeViewController *commendVC = [[CommendResumeViewController alloc] init];
        commendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commendVC animated:YES];
    }else
    {
        NSLog(@"查看第%ld个人的简历",(long)index);
        ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
        infoVC.resumeID = 117377;
        infoVC.userID = 117377;
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    
}
#pragma mark - 刷新数据
-(void)reloadData
{
    //刷新 应聘部分 hireArray 按照假数据来重新获取
    [hireOfView loadItem:hireArray];
    //刷新推荐部分 commendArray重新获取
    [commendView loadSubView:commendArray];
}
#pragma mark - 企业状态
-(BOOL)getEnterpriseCheckState
{
    return YES;
//    return NO;
}
#pragma mark - 从服务器获取信息
-(void)requestInfoFromWeb
{
    NSArray *jsonArray = [NSArray arrayWithObjects:[CombiningData getPicList],[CombiningData getUIDInfo:kNumberList], nil];
    __block int requestCount = 0;
    [self showHUD:@"正在加载数据"];
    for (int i=0; i < [jsonArray count]; i++) {
        NSString *jsonString = [jsonArray objectAtIndex:i];
        
        //请求服务器
        [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost WithSSl:nil];
        [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
            requestCount++;
            if (requestCount==[jsonArray count]) {
                [self hideHUD];
            }
            if (result!=nil) {
                if ([[result objectForKey:@"result"] intValue]>0) {
                    [self dealWithData:result];
                }else
                {
                    NSLog(@"error message == %@",[result objectForKey:@"message"]);
                }
            }else
            {
//                [self showAlertView:@"服务器请求失败"];
            }
        };

    }
}
-(void)dealWithData:(id)result
{
    NSString *json = [result objectForKey:@"requestJson"];
    NSDictionary *dic = [Util dictionaryWithJsonString:json];
    NSString *type = [dic objectForKey:@"type"];
    if ([type isEqualToString:kPictureList]) {
        bannerArray = [NSArray arrayWithArray:[result objectForKey:@"data"]];
        [bannerView loadBannerImage:bannerArray];
    }else if ([type isEqualToString:kNumberList])
    {
        NSLog(@"data == %@",[result objectForKey:@"data"]);
        NSArray *resultArr = [result objectForKey:@"data"];
        if ([resultArr count]>0) {
            NSArray *array = [self getHireData:[resultArr firstObject]];
            [hireOfView loadItem:array];
        }
       
   
    }
 }
#pragma mark - 应聘信息数组
-(NSMutableArray*)getHireData:(NSDictionary*)dataDic
{
    NSArray *titleArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"职位",@"string", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"急招",@"string", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已下载",@"string", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"已收到",@"string",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"发布职位",@"string",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"收藏",@"string",nil], nil];
    if (dataDic==nil) {
        return (NSMutableArray*)titleArray;
    }else
    {
        NSArray *keyArray = [NSArray arrayWithObjects:@"job",@"emergent",@"download",@"apply",@"position",@"favorite", nil];
        NSMutableArray *resultArray = [NSMutableArray array];
        for (int i = 0; i< [titleArray count]; i++) {
            NSString *keyString = [keyArray objectAtIndex:i];
            NSString *content = [dataDic objectForKey:keyString];
            NSDictionary * dic = [titleArray objectAtIndex:i];
            if ([Util getCorrectString:content]>0) {
                NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
                if (i==0) {
                    NSString *string = [NSString stringWithFormat:@"%@ %@个",[dic objectForKey:@"string"],content];
                    [newDic setObject:string forKey:@"string"];
                    [newDic setObject:[NSString stringWithFormat:@"%@个",content] forKey:@"substring"];
                }else if (i==1)
                {
                    NSString *string = [NSString stringWithFormat:@"%@ 剩余%@时",[dic objectForKey:@"string"],[content substringToIndex:1]];
                    [newDic setObject:string forKey:@"string"];
                    [newDic setObject:[NSString stringWithFormat:@"剩余%@时",[content substringToIndex:1]] forKey:@"substring"];
                }else
                {
                    NSString *string = [NSString stringWithFormat:@"%@ %@份",[dic objectForKey:@"string"],content];
                    [newDic setObject:string forKey:@"string"];
                    [newDic setObject:[NSString stringWithFormat:@"%@份",content] forKey:@"substring"];
                
                }
                [resultArray addObject:newDic];
            }else
            {
                NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
               
                [newDic setObject:@"" forKey:@"substring"];
                [resultArray addObject:newDic];
           
            }
            
        }
        
        return resultArray;
   
    }
}
@end

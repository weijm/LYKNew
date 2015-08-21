//
//  CommendResumeForJobViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CommendResumeForJobViewController.h"
#import "UIButton+Custom.h"
#import "FooterView.h"
#import "FiltratePickerView.h"
#import "ResumeInfoViewController.h"


@interface CommendResumeForJobViewController ()
{
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    FiltrateView *filtrateView;
    
    UIView *headerView;
    
    int currentPage;
    BOOL isLoading;
    //是否是搜索
    BOOL isSearching;
}
@end

@implementation CommendResumeForJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.view.backgroundColor = kCVBackgroundColor;
    //初始化编辑按钮
    [self initItems];
    //初始化headerView
//    [self initHeaderView];
    
    currentPage = 1;
    isLoading = NO;
    isSearching = NO;

    if (!_isForPisition) {
        self.title = @"更多推荐简历";
        //导航条的颜色
        [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        [self performSelector:@selector(requestInfoFromWeb) withObject:nil afterDelay:0.0];
        
    }else//从简历管理里面进入的
    {
        //获取数据
        [self performSelector:@selector(requestResumeListFromPosition:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.0];
    }
   
    //设置tableView
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorColor = [UIColor clearColor];
    [dataTableView setupRefresh];
    __weak CommendResumeForJobViewController *wself = self;
    dataTableView.refreshData = ^{
        CommendResumeForJobViewController *sself = wself;
        [sself refreshData];
    };
   
    //获取数据
//    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    if (!_isForPisition) {
        [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
}
#pragma mark - 编辑按钮
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
//
//    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
//    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
//    imageInsets = rightBt.imageEdgeInsets;
//    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
//    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
//    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
//    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
-(void)leftAction
{
    if(footerView)
    {
        [footerView cancelFooterView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];
        

        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];

        
    }
    [dataTableView reloadData];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"CommendForJobID";
    CommendResumeForJobTableViewCell *cell = (CommendResumeForJobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommendResumeForJobTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //加载视图数据
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    if (_isForPisition) {
        cell.isShowRateView = NO;
    }
    [cell loadSearchResumeData:dic];
    //全部选中按钮使用
    cell.tag = indexPath.row;
    NSString *isSelected;
    if (rightBt.specialMark==1) {
        isSelected = [chooseArray objectAtIndex:indexPath.row];
    }else
    {
        isSelected = @"0";
    }
    //加载全部选中按钮的状态
    [cell changeLocation:rightBt.specialMark Selected:[isSelected intValue] ];
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:6];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [Util myYOrHeight:11];
//    if (rightBt.specialMark == 1) {
//        return [Util myYOrHeight:11];
//    }else
//    {
//        return [Util myYOrHeight:35];
//    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:11])];
    view.backgroundColor = [UIColor clearColor];
    return view;
//    if (rightBt.specialMark == 1) {
//        headerView.hidden = YES;
//    }else
//    {
//        headerView.hidden = NO;
//    }
//    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rightBt.specialMark ==1) {
        return;
    }
    ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
    NSDictionary *dic = nil;
    dic = [dataArray objectAtIndex:indexPath.row];
    infoVC.resumeID = [[dic objectForKey:@"id"] intValue];
    infoVC.sex = [dic objectForKey:@"sex"];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
    
}
-(void)initHeaderView
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:35])];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = kCVBackgroundColor;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, [Util myYOrHeight:35]-4.5, kWidth, 0.5)];
    line.backgroundColor = Rgb(150, 204, 243, 0.7);
    [headerView addSubview:line];
    headerView.userInteractionEnabled = NO;
    
    float btW = [Util myXOrWidth:150];
    UIButton *filtrateBt = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-btW)/2, 3, btW, [Util myYOrHeight:35]-5)];
    [filtrateBt setTitle:@"综合筛选" forState:UIControlStateNormal];
    [filtrateBt setTitleColor:Rgb(76, 80, 83, 1.0) forState:UIControlStateNormal];
    [filtrateBt addTarget:self action:@selector(filtrateAction) forControlEvents:UIControlEventTouchUpInside];
    filtrateBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:filtrateBt];
    
    UIView *imgbg = [[UIView alloc] initWithFrame:CGRectMake(filtrateBt.frame.origin.x+btW-[Util myXOrWidth:48], 3, 30, filtrateBt.frame.size.height)];
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, (filtrateBt.frame.size.height-7)/2, 4, 7)];
    arrowImg.image = [UIImage imageNamed:@"resume_filtrate_arrow"];
    [imgbg addSubview:arrowImg];
    [headerView addSubview:imgbg];
}
#pragma -mark - 综合筛选的事件
-(void)filtrateAction
{
    if (isLoading) {//正在加载更多时 不可以筛选
        return;
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    float filtrateH = topBarheight;
    CGRect frame = CGRectMake(0, filtrateH, kWidth, kHeight-filtrateH);
    filtrateView = [[FiltrateView alloc] initWithFrame:frame];
    filtrateView.delegate = self;
    //根据所选简历分类 加载的筛选内容不同
    [filtrateView changeTitleArray:2];
    [self.view addSubview:filtrateView];
    
}
#pragma mark - 综合筛选FiltrateViewDelegate
-(void)didSelectedRow:(int)row
{
    if (row ==0) {
        return;
    }
    CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
    int style = 0;
    if(row == 5)//地区
    {
        style = 2;
    }else if(row == 3||row==0)//专业 此处修改[self showConditions: Content:]随着修改
    {
        style = 1;
    }
    FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
    pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
        [self showConditions:index Content:dictionary];
    };
    pickerView.categoryType = 2;
    [pickerView loadData:row];
    [pickerView showInView:self.view];
    
}
-(void)makeSureOrCancelAction:(BOOL)sureOrCancel Conditions:(NSArray *)conditionArray
{
    if (sureOrCancel) {
        isSearching = YES;
        currentPage = 1;//筛选的第一页
        NSMutableArray *conArray = [NSMutableArray arrayWithArray:conditionArray];
        //
        //确定搜索条件 进行搜索
        [filtrateView removeFromSuperview];
    }else
    {
        [filtrateView removeFromSuperview];
        if (isSearching) {//之前筛选过 有残留数据
            isSearching = NO;
            currentPage = 1;
            
        }
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
#pragma mark -将筛选条件显示到界面
-(void)showConditions:(int)row Content:(NSDictionary*)dictionary
{
    if (row == 5 || row == 3 || row ==0) {//地区 此处可以查询对应的id
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
        [filtrateView reloadTableView:row withContent:dic];
    }else
    {//其他
        [filtrateView reloadTableView:row withContent:dictionary];
    }
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    //初始化按钮
    [footerView loadEditButton:2];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[NSArray arrayWithObjects:@"200", nil]Enable:NO];
    //点击按钮的触发事件
    __weak CommendResumeForJobViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        CommendResumeForJobViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = footerView.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        footerView.frame = frame;
    }];
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    switch (index) {
        case 100:
        {
            NSString *allString = isAll?@"1":@"0";
            for (int i =0; i < [chooseArray count]; i++) {
                [chooseArray replaceObjectAtIndex:i withObject:allString];
            }
            [dataTableView reloadData];
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:isAll];
        }
            break;
        case 200:
            break;
            
        default:
            break;
    }
    
}
#pragma mark - SearchResumeTableViewCellDelegate
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}
#pragma mark - 获取数据
-(void)getData
{
    dataArray = [[NSMutableArray alloc] init];
    NSString *jobStr = @"软件工程师";
    
    for (int i =0; i < 6; i++) {
        NSString *job = [NSString stringWithFormat:@"%@%d",jobStr,i];
        NSString *time = [NSString stringWithFormat:@"08-%d",i+10];
        NSString *name = [NSString stringWithFormat:@"张晓%d",i];
        NSString *age = [NSString stringWithFormat:@"%d",i];
        NSString *money = [NSString stringWithFormat:@"%d-%d",500*(i+1),800*(i+1)];
        NSString *exp = (i%3==0)?@"有工作经验":@"";
        NSString *urgent = @"0";
        NSString *colledted = @"0";
        NSString *download = @"0";
        
        [dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:job,@"job",urgent,@"urgent",colledted,@"collected",download,@"download",time,@"time",name,@"name",@"女",@"sex",@"UI设计师",@"selfjob",age,@"age",@"本科",@"record",money,@"money",@"艺术设计",@"professional",@"中国传媒大学",@"school",exp,@"experience",nil]];
    }
    
    [dataTableView reloadData];
    chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
    for (int i=0; i< [dataArray count]; i++) {
        [chooseArray addObject:@""];
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
#define  mark - 获取更多推荐简历
-(void)requestInfoFromWeb
{
    NSString *jsonString = [CombiningData getUIDInfo:kCommendList];
    __block int requestCount = 0;
    [self showHUD:@"正在加载数据"];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                dataArray = [result objectForKey:@"data"];
                [dataTableView reloadData];
                
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
            //                [self showAlertView:@"服务器请求失败"];
        }
    }];
//    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost WithSSl:nil];
//    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
//        requestCount++;
//        
//        if (result!=nil) {
//            if ([[result objectForKey:@"result"] intValue]>0) {
//                [self hideHUD];
//                dataArray = [result objectForKey:@"data"];
//                [dataTableView reloadData];
//                
//            }else
//            {
//                [self hideHUDFaild:[result objectForKey:@"message"]];
//            }
//        }else
//        {
//            [self hideHUDFaild:@"服务器请求失败"];
//            //                [self showAlertView:@"服务器请求失败"];
//        }
//    };
    
}

#pragma mark - 获取职位收到的简历
-(void)requestResumeListFromPosition:(BOOL)isMore
{
    
    int page = currentPage;
    NSString *jsonString = nil;
    if (!isMore) {
        [self showHUD:@"正在加载数据"];
    }
    if (isSearching) {//正在筛选 筛选json
        
    }else
    {
        jsonString = [CombiningData getResumeListFromPosiotion:_jobId  PageIndex:page IsUrgent:@"0"];
    }
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                //加载首页数据
                NSArray *dataArr = [result objectForKey:@"data"];
                //全选数组标记
                if(page==1)
                {   //如果第一页 加载的时候 初始化 chooseArray 否则直接增加到数组中
                    chooseArray = [NSMutableArray array];
                }
                for (int i=0; i< [dataArr count]; i++) {
                    [chooseArray addObject:@""];
                }
                [self dealWithResponeData:dataArr];
                //将提示视图取消
                if (!isMore) {
                    [self hideHUD];
                }else
                {
                    [dataTableView stopRefresh];
                    isLoading = NO;
                    [self subViewEnabled:YES];
                }
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"数据为空";
                }
                if (!isMore) {
                    [self hideHUDFaild:message];
                }else
                {
                    NSString *msg = [result objectForKey:@"message"];
                    if ([msg isEqualToString:@"该职位下暂无投递简历"]) {
                        [dataTableView changeProText:YES];
                        [self performSelector:@selector(stopRefreshLoading) withObject:nil afterDelay:0.25];
                    }else
                    {
                        [self stopRefreshLoading];
                    }
                }
                
            }
        }else
        {
            if (!isMore) {
                [self hideHUDFaild:@"服务器请求失败"];
            }else
            {
                [dataTableView stopRefresh];
                isLoading = NO;
                [self subViewEnabled:YES];
            }
            
        }

    }];
    
//    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost WithSSl:nil];
//    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
//        if (result!=nil) {
//            if ([[result objectForKey:@"result"] intValue]>0) {
//                //加载首页数据
//                NSArray *dataArr = [result objectForKey:@"data"];
//                //全选数组标记
//                if(page==1)
//                {   //如果第一页 加载的时候 初始化 chooseArray 否则直接增加到数组中
//                    chooseArray = [NSMutableArray array];
//                }
//                for (int i=0; i< [dataArr count]; i++) {
//                    [chooseArray addObject:@""];
//                }
//                [self dealWithResponeData:dataArr];
//                //将提示视图取消
//                if (!isMore) {
//                    [self hideHUD];
//                }else
//                {
//                    [dataTableView stopRefresh];
//                    isLoading = NO;
//                    [self subViewEnabled:YES];
//                }
//                
//            }else
//            {
//                NSString *message = [result objectForKey:@"message"];
//                if ([message length]==0) {
//                    message = @"数据为空";
//                }
//                if (!isMore) {
//                    [self hideHUDFaild:message];
//                }else
//                {
//                    NSString *msg = [result objectForKey:@"message"];
//                    if ([msg isEqualToString:@"该职位下暂无投递简历"]) {
//                        [dataTableView changeProText:YES];
//                        [self performSelector:@selector(stopRefreshLoading) withObject:nil afterDelay:0.25];
//                    }else
//                    {
//                        [self stopRefreshLoading];
//                    }
//                }
//                
//            }
//        }else
//        {
//            if (!isMore) {
//                [self hideHUDFaild:@"服务器请求失败"];
//            }else
//            {
//                [dataTableView stopRefresh];
//                isLoading = NO;
//                [self subViewEnabled:YES];
//            }
//            
//        }
//    };

}
//停止刷新
-(void)stopRefreshLoading
{
    [dataTableView stopRefresh];
    isLoading = NO;
    [self subViewEnabled:YES];
    [dataTableView changeProText:NO];
}
-(void)dealWithResponeData:(NSArray*)array
{
    if (currentPage>1) {
        [dataArray addObjectsFromArray:array];
    }else
    {
        dataArray = [NSMutableArray arrayWithArray:array];
    }
    currentPage++;
        [dataTableView reloadData];
    if ([dataArray count]>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        headerView.userInteractionEnabled = YES;
    }
}
#pragma mark - 加载数据中 不可以点击本页的事件
-(void)subViewEnabled:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
    self.navigationItem.leftBarButtonItem.enabled = enable;
    headerView.userInteractionEnabled = enable;
}
//刷新加载更多
-(void)refreshData
{
    if (rightBt.specialMark == 0) {//不处于编辑状态 可以加载更多
        isLoading = YES;
        //请求数据
        [self requestResumeListFromPosition:YES];
        //本页其他事件不可触发
        [self subViewEnabled:NO];
    }else
    {
        [dataTableView stopRefresh];
    }
}

@end

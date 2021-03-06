//
//  InfoViewController.m
//  信息首页
//
//  Created by wjmon 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoViewController.h"
#import "UIButton+Custom.h"
#import "FooterView.h"
#import "InfoDetailViewController.h"
#import "InfoFiltrateView.h"

@interface InfoViewController ()
{
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    NSMutableArray *chooseArray;
    
    UIButton_Custom *filtrateBt;
    
    InfoFiltrateView *infoFiltrateView;
    int currentPage;
    
    
    BOOL isLoading;
    
    int selectedFilter;
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"信息";
    self.view.backgroundColor = kCVBackgroundColor;
    //初始化编辑按钮
    [self initItems];
    
    [self getData];
    
    [dataTableView setupRefresh];
    __weak InfoViewController *wself = self;
    dataTableView.refreshData = ^{
        InfoViewController *sself = wself;
        [sself refreshData];
    };
    currentPage = 1;
    selectedFilter = 0;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(requestData) withObject:nil afterDelay:0.0];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestData
{
    [self requestMsgList:NO];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"InfoTableViewCellID";
    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //加载视图数据
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    
    [cell loadInfoData:dic];
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
   
    return [Util myYOrHeight:55];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rightBt.specialMark ==1) {
        return;
    }
    InfoDetailViewController *infoDetailVC = [[InfoDetailViewController alloc] init];
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    infoDetailVC.infoId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    infoDetailVC.infoStatus = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
    [self.navigationController pushViewController:infoDetailVC animated:YES];
    
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
    
//    filtrateBt = [[UIButton_Custom alloc] initWithFrame:frame];
//    [filtrateBt setImage:[UIImage imageNamed:@"my_info_filtrate_bt"] forState:UIControlStateNormal];
//    imageInsets = filtrateBt.imageEdgeInsets;
//    filtrateBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
//    [filtrateBt addTarget:self action:@selector(filtrateAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:filtrateBt];
    
    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem,rightItem1, nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
-(void)leftAction
{
    if(footerView)
    {
        [footerView cancelFooterView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)filtrateAction
//{
//    if (filtrateBt.specialMark == 0) {//出现筛选页面
//        float viewX = kWidth - 130-[Util myXOrWidth:25];
//        CGRect  frame = CGRectMake(viewX, 0, 130, 101);
//        infoFiltrateView = [[InfoFiltrateView alloc] initWithFrame:frame];
//        __weak InfoViewController *wself = self;
//        infoFiltrateView.touchAction = ^(int index){
//            InfoViewController *sself = wself;
//            [sself filtrateViewAction:index];
//        };
//        [infoFiltrateView showInView:self.view];
//        
//        filtrateBt.specialMark = 1;
//        rightBt.enabled = NO;
//    }else
//    {
//        [infoFiltrateView cancelView];
//        filtrateBt.specialMark = 0;
//        
//        rightBt.enabled = YES;
//    }
//}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];
        
        filtrateBt.enabled = NO;
        for (int i =0; i < [dataArray count]; i++) {
            [chooseArray replaceObjectAtIndex:i withObject:@"0"];
        }
        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];
        filtrateBt.enabled = YES;
        
        
    }
    [dataTableView reloadData];
}
//-(void)filtrateViewAction:(int)index
//{
//    if (index == 0) {//点击任何地方时取消了筛选视图
//        filtrateBt.specialMark = 0;
//        
//        rightBt.enabled = YES;
//    }else if (index == 1)
//    {
//        NSLog(@"消息");
//    }else
//    {
//        NSLog(@"通知");
//    }
//    
//    
//}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.position = 3;//信息页面加载footerView时 position为3
    //初始化按钮
    [footerView loadEditButton:2];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[NSArray arrayWithObjects:@"100",@"200", nil]Enable:NO];
    //点击按钮的触发事件
    __weak InfoViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        InfoViewController *sself = wself;
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
    NSMutableArray *idsArr = [NSMutableArray array];
    for (int i =0; i < [chooseArray count]; i++) {
        NSString *value = [chooseArray objectAtIndex:i];
        if ([value intValue]==1) {
            NSDictionary *dic = [dataArray objectAtIndex:i];
            [idsArr addObject:[dic objectForKey:@"id"]];
        }
    }
    NSString *ids = [CombiningData getIdsByArray:idsArr];
    switch (index) {
        case 100:
        {
            //置为已读
            [self requestSetMsg:ids Type:1];
        }
            break;
        case 200:
        {
            //删除
            [self requestSetMsg:ids Type:2];
        }
            break;
            
        default:
            break;
    }
    
    //还原界面
    [self rightAction];
}
#pragma mark - SearchResumeTableViewCellDelegate
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[NSArray arrayWithObjects:@"100",@"200", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"100",@"200", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}

#pragma mark - 获取数据
-(void)getData
{
//    dataArray = [[NSMutableArray alloc] init];
//    NSString *infoStr = @"消息标题";
//    NSString *notiStr = @"通知标题";
//    for (int i =0; i < 6; i++) {
//        NSString *title = (i%2==0)?infoStr:notiStr;
//        NSString *titleStr = [NSString stringWithFormat:@"%@%d",title,i];
//        NSString *time = [NSString stringWithFormat:@"08/%d",i+10];
//        NSString *info = [NSString stringWithFormat:@"消息摘要%d消息摘要%d消息摘要%d消息消息消息消息消息消息",i,i,i];
//        NSString *type = (i%2==0)?@"1":@"2";
//        
//        [dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:titleStr,@"title",info,@"info",type,@"type",time,@"time",nil]];
//    }
//    
//    [dataTableView reloadData];
//    chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
//    for (int i=0; i< [dataArray count]; i++) {
//        [chooseArray addObject:@""];
//    }
}
-(void)refreshData
{
    [dataTableView stopRefresh];
}
#pragma mark - 请求服务器
-(void)requestMsgList:(BOOL)isMore
{
    int page = currentPage;
    
    if (!isMore) {
        [self showHUD:@"正在加载数据"];
    }
    NSString *listJson = [CombiningData getMsgList:page];
    
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
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
                //将提示视图取消
                if (!isMore) {
                    [self hideHUD];
                    dataArray = [NSMutableArray arrayWithArray:dataArr];
                    
                }else
                {
                    isLoading = NO;
                    [dataTableView stopRefresh];
                    [dataArray addObjectsFromArray:dataArr];
                   
                }
                if ([dataArray count]>0) {
                    [self subViewEnabled:YES];
                }else
                {
                    [self subViewEnabled:NO];
                }
                
                 [dataTableView reloadData];
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"暂无信息";
                }
                if (!isMore) {
                    dataArray = nil;
                    [dataTableView reloadData];
                    self.navigationItem.rightBarButtonItem.enabled = NO;
                    [self hideHUDFaild:message];
                }else
                {
                    //                    NSString *msg = [result objectForKey:@"message"];
                    [dataTableView changeProText:YES];
                    [self performSelector:@selector(stopRefreshLoading) withObject:nil afterDelay:0.5];
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
}
-(void)subViewEnabled:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
    
    
}
//停止刷新
-(void)stopRefreshLoading
{
    [dataTableView stopRefresh];
    isLoading = NO;
    [self subViewEnabled:YES];
    [dataTableView changeProText:NO];
}

-(void)requestSetMsg:(NSString*)ids Type:(int)type
{
    if (type==1) {
        [self showHUD:@"正在请求置为已读"];
    }else
    {
        [self showHUD:@"正在请求删除"];
    }
    NSString *listJson = [CombiningData setMsg:ids Type:type];
    
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                if (type==1) {
                    [self hideHUDWithComplete:@"置为已读完成"];
                }else
                {
                    [self hideHUDWithComplete:@"删除成功"];
                }
                [self performSelector:@selector(requestData) withObject:nil afterDelay:0.5];
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
            }
        }else
        {
             [self hideHUDFaild:@"请求服务器失败"];
        }
        
    }];

}
@end

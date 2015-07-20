//
//  ResumeViewController.m
//  简历首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeViewController.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "FiltratePickerView.h"
#import "ResumeInfoViewController.h"


#define kHeaderViewHeight [Util myYOrHeight:80]

@interface ResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //头部点击的各个按钮
    HeaderView *headerView;
    //编辑全部的底部视图
    FooterView *footerView;
    UITableView *dataTableView;
    //收到的简历数据数组
    NSMutableArray *dataArray;
    //当前操作的cell
    ResumeTableViewCell *currentCell;
    //点击事件
    UITapGestureRecognizer *tap;
   //是否出现全部编辑的标志
    BOOL isEdit;
    //简历类别
    int resumeCategory; //1:收到的简历 2：收藏的简历 3：已下载的简历
    //全选时 选择记录数组
    NSMutableArray *chooseArray;
    //筛选视图
    FiltrateView *filtrateView;
}
@end
@implementation ResumeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //导航条右侧按钮
    [self initItems];
    self.view.backgroundColor = Rgb(220, 241, 252, 1.0);
    //初始化headerView
    [self initHeaderView];
    dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:0]];
    [self initTableView];
    isEdit = NO;
    //默认是收到的简历
    resumeCategory = 1;
    chooseArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[dataArray count]; i++) {
        [chooseArray addObject:@"0"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - navigation上的左右按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - 导航条右侧按钮的点击事件
-(void)rightAction
{
    if (isEdit) {
        isEdit = NO;
        if (chooseArray) {
            [chooseArray removeAllObjects];
        }
        chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
        for (int i=0; i < [dataArray count]; i++) {
            [chooseArray addObject:@"0"];
        }
        //tableView取消编辑的时候 按钮之间可相互切换
        headerView.userInteractionEnabled = YES;
        
        FooterView *fooerView = (FooterView*)[self.view.window viewWithTag:1000];
        [fooerView cancelFooterView];
        
    }else
    {
        isEdit = YES;
        //tableView可编辑的时候 按钮之间不能相互切换
        headerView.userInteractionEnabled = NO;
        [self initFooerView];
    }
    [dataTableView reloadData];
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.tag = 1000;
    //初始化按钮
    [footerView loadEditButton:resumeCategory];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[self getEnableBtArray] Enable:NO];
    //点击按钮的触发事件
    __weak ResumeViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        ResumeViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = footerView.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        footerView.frame = frame;
    }];

}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kHeaderViewHeight)];
    __weak ResumeViewController *wself = self;
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        ResumeViewController *sself = wself;
        [sself chooseAction:index isChooseAll:NO];
    };
    headerView.clickedFiltrateAction = ^{
        ResumeViewController *sself = wself;
        [sself filtrateAction];
    };
    [self.view addSubview:headerView];
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    if (index < 10) {//HeaderView上的按钮的触发事件
        switch (index) {
            case 0:
                dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:0]];
                resumeCategory = 1;
                
                break;
            case 1:
                dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:1]];
                break;
            case 2:
                dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:2]];
                break;
            default:
                break;
        }
        resumeCategory = (int)index +1;
        [dataTableView reloadData];
        [filtrateView changeTitleArray:resumeCategory];
    }else
    {
        switch (index) {
            case 10:
            case 100:
            case 1000:
            {
                NSString *allString = isAll?@"1":@"0";
                for (int i =0; i < [chooseArray count]; i++) {
                    [chooseArray replaceObjectAtIndex:i withObject:allString];
                }
                [dataTableView reloadData];
                [footerView setButton:[self getEnableBtArray] Enable:isAll];
            }
                break;
            case 20:
                NSLog(@"选中简历类型 1 收藏选中的简历");
                break;
            case 30:
                NSLog(@"选中简历类型 1 删除选中的简历");
                break;
            case 200:
                NSLog(@"选中简历类型 2 取消收藏选中的简历");
                break;
            case 2000:
                NSLog(@"选中简历类型 3 收藏选中的简历");
                break;
            case 3000:
                NSLog(@"选中简历类型 3 删除选中的简历");
                break;
            default:
                break;
        }
    }
}
#pragma mark - 筛选按钮触发的事件
-(void)filtrateAction
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.tabBarController.tabBar.hidden = YES;
    float filtrateH = headerView.frame.origin.y+kHeaderViewHeight-[Util myYOrHeight:17];
    CGRect frame = CGRectMake(0, filtrateH, kWidth, kHeight-filtrateH);
    filtrateView = [[FiltrateView alloc] initWithFrame:frame];
    filtrateView.delegate = self;
    //根据所选简历分类 加载的筛选内容不同
    [filtrateView changeTitleArray:resumeCategory];
    [self.view addSubview:filtrateView];
}
#pragma mark - 可点或不可点击的按钮数组
-(NSArray*)getEnableBtArray
{
    NSArray *enableArray = nil;
    if (resumeCategory ==1) {
        enableArray = [NSArray arrayWithObjects:@"20",@"30", nil];
    }else if (resumeCategory ==2)
    {
        enableArray = [NSArray arrayWithObjects:@"200", nil];
    }else
    {
        enableArray = [NSArray arrayWithObjects:@"2000",@"3000", nil];
    }
    return enableArray;
}
#pragma mark -
#pragma mark - 初始化tableView
-(void)initTableView
{
    float tableViewY = topBarheight+kHeaderViewHeight;
    CGRect frame = CGRectMake(0, tableViewY, kWidth, kHeight-tableViewY-[Util myYOrHeight:45]);
    dataTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    dataTableView.separatorColor = [UIColor clearColor];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:dataTableView];
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"ResumCellId";
    ResumeTableViewCell *cell = (ResumeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResumeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //加载视图数据
    [cell loadSubView:[dataArray objectAtIndex:indexPath.row]];
    //全部选中按钮使用
    cell.tag = indexPath.row;
    NSString *isSelected;
    if (isEdit) {
        isSelected = [chooseArray objectAtIndex:indexPath.row];
    }else
    {
        isSelected = @"0";
    }
    //加载全部选中按钮的状态
    [cell changeLocation:isEdit Selected:[isSelected intValue] ];
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标签的高度
//    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.row];
//    NSArray *subArray = [dictionary objectForKey:@"sign"];
//    int row = [Util getRow:(int)[subArray count] eachCount:4];
//    float bottomH = [self getCellBottomHeight:row];
    return kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:6];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeInfoViewController *infoVC = [[ResumeInfoViewController alloc] init];
 
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
}
#pragma mark - 根据标签的行数确定cell的高度
//-(CGFloat)getCellBottomHeight:(int)row
//{
//    float bottomH;
//    if (row ==1) {
//        bottomH = (kIphone6plus)?30:(kIphone6)?33:35;
//    }else if(row==2)
//    {
//        bottomH = (kIphone6plus)?25:(kIphone6)?26:28;
//    }else
//    {
//        bottomH = (kIphone6plus)?23:(kIphone6)?24:25;
//    }
//    return [Util myYOrHeight:bottomH]*row;
//}
#pragma mark - ResumeTableViewCellDelegate
-(void)revertLeftOrRightSwipView:(ResumeTableViewCell*)cell selected:(BOOL)isSelected
{
    if (isSelected) {
        if (currentCell) {
            [currentCell revertView];
        }
        currentCell = cell;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(revertCell)];
        [dataTableView addGestureRecognizer:tap];
    }
}
-(void)revertCell
{
    [currentCell revertView];
    [dataTableView removeGestureRecognizer:tap];
}
//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[self getEnableBtArray] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[self getEnableBtArray] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}
#pragma mark - 综合筛选FiltrateViewDelegate
-(void)didSelectedRow:(int)row
{
    CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
    int style = 0;
    if(row == 5)//地区
    {
        style = 2;
    }else if(row == 3||row==0)//专业 此处修改[self showConditions: Content:]随着修改
    {
        style = 1;
    }
//    NSArray *titleArray = [NSArray arrayWithObjects:@"按 职  位",@"阅读状态",@"学      历",@"期望薪资",@"专      业",@"期望城市",@"工作经验", nil];
    
    FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
    pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
        [self showConditions:index Content:dictionary];
    };
    pickerView.categoryType = resumeCategory;
//    pickerView.titleLab.text = [titleArray objectAtIndex:row];
    [pickerView loadData:row];
    [pickerView showInView:self.view];
    
}
-(void)makeSureOrCancelAction:(BOOL)sureOrCancel Conditions:(NSArray *)conditionArray
{
    if (sureOrCancel) {
        NSLog(@"确定 筛选条件");
        NSMutableArray *conArray = [NSMutableArray arrayWithArray:conditionArray];
        NSLog(@"conditionArray == %@",conArray);
        //确定搜索条件 进行搜索
        [filtrateView removeFromSuperview];
    }else
    {
        NSLog(@"取消");
        [filtrateView removeFromSuperview];
    }
    self.tabBarController.tabBar.hidden = NO;
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
#pragma mark - 获取数据
-(NSMutableArray*)getContentData:(int)index
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *jobStr;
    if (index==0) {
        jobStr = @"软件工程师";
    }else if (index ==1)
    {
        jobStr = @"交互设计师";
    }else
    {
        jobStr = @"测试工程师";
    }
    for (int i =0; i < 6+index; i++) {
        NSString *job = [NSString stringWithFormat:@"%@%d",jobStr,i];
        NSString *time = [NSString stringWithFormat:@"15-08-0%d",i];
        NSString *name = [NSString stringWithFormat:@"张晓%d%d",index,i];
        NSString *age = [NSString stringWithFormat:@"%d%d",index+1,i];
        NSString *money = [NSString stringWithFormat:@"%d-%d",500*(i+1),800*(i+1)];
        NSString *exp = (i%(index+1)==0)?@"有工作经验":@"";
        NSString *urgent = (i%(index+1)==0)?@"1":@"0";
        NSString *colledted = (i%4==0)?@"1":@"0";
        NSString *download = (i%2 == 0)?@"1":@"0";
        
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:job,@"job",urgent,@"urgent",colledted,@"collected",download,@"download",time,@"time",name,@"name",@"女",@"sex",@"UI设计师",@"selfjob",age,@"age",@"本科",@"record",money,@"money",@"艺术设计",@"professional",@"中国传媒大学",@"school",exp,@"experience",nil]];
    }
    return array;
}
@end

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
    //只有收到的简历有编辑效果
    if (resumeCategory==1) {
        if (isEdit) {
            isEdit = NO;
            for (int i=0; i < [chooseArray count]; i++) {
                NSString *string = [chooseArray objectAtIndex:i];
                if ([string intValue]==1) {
                    [chooseArray replaceObjectAtIndex:i withObject:@"0"];
                }
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
 
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.tag = 1000;
    [footerView setButton:[NSArray arrayWithObjects:@"20",@"30", nil] Enable:NO];
    __weak ResumeViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        ResumeViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [footerView showFooterView:self.view];
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
                //编辑按钮可点
                self.navigationItem.rightBarButtonItem.enabled = YES;
                break;
            case 1:
                dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:1]];
                //编辑按钮不可点
                self.navigationItem.rightBarButtonItem.enabled = NO;
                break;
            case 2:
                dataArray = [[NSMutableArray alloc] initWithArray:[self getContentData:2]];
                //编辑按钮不可点
                self.navigationItem.rightBarButtonItem.enabled = NO;
                break;
            default:
                break;
        }
        resumeCategory = (int)index +1;
        [dataTableView reloadData];
    }else
    {
        switch (index) {
            case 10:
            {
                NSString *allString = isAll?@"1":@"0";
                for (int i =0; i < [chooseArray count]; i++) {
                    [chooseArray replaceObjectAtIndex:i withObject:allString];
                }
                [dataTableView reloadData];
                [footerView setButton:[NSArray arrayWithObjects:@"20",@"30", nil] Enable:isAll];
            }
                break;
            case 20:
                NSLog(@"收藏选中的简历");
                
                break;
            case 30:
                NSLog(@"删除选中的简历");
                break;
            default:
                break;
        }
    }
   
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
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.row];
    NSArray *subArray = [dictionary objectForKey:@"sign"];
    int row = [Util getRow:(int)[subArray count] eachCount:4];
    float bottomH = [self getCellBottomHeight:row];

    
    return bottomH + kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:6];
}
#pragma mark - 根据标签的行数确定cell的高度
-(CGFloat)getCellBottomHeight:(int)row
{
    float bottomH;
    if (row ==1) {
        bottomH = (kIphone6plus)?30:(kIphone6)?33:35;
    }else if(row==2)
    {
        bottomH = (kIphone6plus)?25:(kIphone6)?26:28;
    }else
    {
        bottomH = (kIphone6plus)?23:(kIphone6)?24:25;
    }
    return [Util myYOrHeight:bottomH]*row;
}
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
            [footerView setButton:[NSArray arrayWithObjects:@"20",@"30", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"20",@"30", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
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
        NSMutableArray *subArr = [[NSMutableArray alloc] init];
        for (int j =0; j<=i+index; j++) {
            [subArr addObject:@"标签名称"];
        }
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:job,@"job",urgent,@"urgent",colledted,@"collected",download,@"download",time,@"time",name,@"name",@"女",@"sex",@"UI设计师",@"selfjob",age,@"age",@"本科",@"record",money,@"money",@"艺术设计",@"professional",@"中国传媒大学",@"school",exp,@"experience",subArr,@"sign",nil]];
    }
    
    return array;
}
@end

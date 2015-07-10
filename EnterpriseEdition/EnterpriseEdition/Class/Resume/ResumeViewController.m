//
//  ResumeViewController.m
//  简历首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ResumeViewController.h"
#import "HeaderView.h"
#import "ResumeTableViewCell.h"

#define kHeaderViewHeight [Util myYOrHeight:80]

@interface ResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dataTableView;
    //数据数组
    NSArray *dataArray;
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
    
    dataArray = [[NSArray alloc] initWithArray:[self getContentData:0]];
    
    [self initTableView];
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
    NSLog(@"rightAction");
}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, kHeaderViewHeight)];
    headerView.chooseHeaderBtAction = ^(NSInteger index){
        [self chooseAction:index];
    };
    [self.view addSubview:headerView];
}
#pragma mark - headerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"收到的简历");
            dataArray = [[NSArray alloc] initWithArray:[self getContentData:0]];
            break;
        case 1:
            dataArray = [[NSArray alloc] initWithArray:[self getContentData:1]];
            NSLog(@"收藏的简历");
            break;
        case 2:
            dataArray = [[NSArray alloc] initWithArray:[self getContentData:2]];
            NSLog(@"已下载的简历");
            break;
        default:
            break;
    }
    [dataTableView reloadData];
}
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
    [cell loadSubView:[dataArray objectAtIndex:indexPath.row]];
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

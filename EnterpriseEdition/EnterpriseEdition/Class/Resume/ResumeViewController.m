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
    
    dataArray = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:@"标签名称",@"标签名称",@"标签名称", nil],[NSArray arrayWithObjects:@"标签名称",@"标签名称",@"标签名称",@"标签名称", nil],[NSArray arrayWithObjects:@"标签名称",@"标签名称",@"标签名称",@"标签名称",@"标签名称", nil],[NSArray arrayWithObjects:@"标签名称",@"标签名称",@"标签名称",@"标签名称",@"标签名称",@"标签名称", nil], nil];
    
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
    [self.view addSubview:headerView];
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
    [self.view addSubview:dataTableView];
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"ResumCellId";
    ResumeTableViewCell *cell = (ResumeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResumeTableViewCell" owner:self options:nil] lastObject];
        [cell loadSubView:[dataArray objectAtIndex:indexPath.row]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *subArray = [dataArray objectAtIndex:indexPath.row];
    int row = [Util getRow:(int)[subArray count] eachCount:4];
    
    float bottomH = kBottomEachH*row;
    return bottomH + kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:6];
}
@end

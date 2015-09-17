//
//  JobFairInfoViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobFairInfoViewController.h"
#import "JobFairListTableViewCell.h"
#import "ScanCodeViewController.h"

#define kFooterBtH [Util myYOrHeight:35]

@interface JobFairInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BaseTableView *dataTableView;
    NSMutableDictionary *infoDic;
}
@end

@implementation JobFairInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"招聘会详情";
    
    infoDic = [NSMutableDictionary dictionaryWithDictionary:_jobFairInfoDic];
    [infoDic setObject:@"招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介招聘会简介" forKey:@"info"];
    [infoDic setObject:@"特别提示特别提示特别提示特别提示特别提示特别提示特别提示特别提示特别提示特别提示" forKey:@"note"];
    [self initTableView];
    
    [self initFooterView];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initFooterView
{
    int state = [[infoDic objectForKey:@"status"] intValue];
    NSString *titStr = nil;
    BOOL btEnabled = NO;
    UIColor *btBg = Rgb(188, 189, 190, 1.0);;
    if (state == -1) {
        titStr = @"立即报名";
        btEnabled = YES;
        btBg = Rgb(69, 170, 253, 1.0);
    }else if (state ==0)
    {
        titStr = @"审核成功";
    }
    else if (state ==1)
    {
        titStr = @"审核中...";
    }else
    {
        titStr = @"已结束";
    }
    UIButton *footerView = [UIButton buttonWithType:UIButtonTypeCustom];
    footerView.frame = CGRectMake(0, kHeight-topBarheight-kFooterBtH, kWidth, kFooterBtH);
    [footerView setTitle:titStr forState:UIControlStateNormal];
    [footerView addTarget:self action:@selector(clickedAction) forControlEvents:UIControlEventTouchUpInside];
    footerView.enabled = btEnabled;
    footerView.backgroundColor = btBg;
    footerView.titleLabel.font = [UIFont systemFontOfSize:[self getLabFontSize]];
    [self.view addSubview:footerView];
    
    
    
}
#pragma mark - 立即报名事件
-(void)clickedAction
{
    NSLog(@"详情中 立即报名");
}
#pragma mark - 初始化数据列表
-(void)initTableView
{
    CGRect frame = CGRectMake(0, 0, kWidth, kHeight-topBarheight-kFooterBtH);
    dataTableView = [[BaseTableView alloc] initWithFrame:frame];
    dataTableView.separatorColor = [UIColor clearColor];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    dataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:dataTableView];
}
#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"JobFairListTableViewCellID";
    JobFairListTableViewCell *cell = (JobFairListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[JobFairListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.tag = indexPath.row;
    //加载数据
    [cell loadSubViewInInfo:infoDic];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return [self getFirstHeight];
    }else if (indexPath.row ==1)
    {
        return [self getSecondHeight];
    }else
    {
        return [self getOtherHeight:(int)indexPath.row];
    }
    
}
#pragma mark - 字体大小
-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
-(float)getContentFontSize
{
    if (kIphone6||kIphone6plus) {
        return 13;
    }else
    {
        return 12;
    }
}
-(float)getFirstHeight
{
    float cellEdge = [Util myYOrHeight:10];
    float cellHeight = 0;
    float viewW = kWidth-[Util myXOrWidth:10]*2;
    NSString *titStr = [infoDic objectForKey:@"title"];
    CGSize theStringSize = [titStr sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    
    cellHeight = theStringSize.height+cellHeight;
    
    float infoW = viewW - [Util myXOrWidth:15] - [Util myXOrWidth:10];
    NSString *content = [NSString stringWithFormat:@"招聘会时间:  %@",[infoDic objectForKey:@"time"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    content = [NSString stringWithFormat:@"具 体 地 点:  %@",[infoDic objectForKey:@"address"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    content = [NSString stringWithFormat:@"主 办 单 位:  %@",[infoDic objectForKey:@"organizer"]];
    theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
    cellHeight = theStringSize.height+cellHeight;
    
    return cellHeight+5*5+cellEdge;//内容高度 按钮高度 间隔高度  cell间间隔
}

-(float)getSecondHeight
{
    return [Util myYOrHeight:10]*3+18+[Util myYOrHeight:140];
}
-(float)getOtherHeight:(int)index
{
    NSString *content = nil;
    float viewW = kWidth - [Util myXOrWidth:10]*2;
    if (index == 2) {
        content = [infoDic objectForKey:@"info"];
    }else
    {
        content = [infoDic objectForKey:@"note"];
    }
    
    CGSize theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    return theStringSize.height+[Util myYOrHeight:10]*3+18;
    
}
@end

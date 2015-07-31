//
//  ClaimPositionViewController.m
//  职位认领
//
//  Created by wjm on 15/7/28.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ClaimPositionViewController.h"
#import "ClaimPositionPromptView.h"

#import "FooterView.h"

@interface ClaimPositionViewController ()
{
    NSMutableArray *listArray;
    
    FooterView *footerView;
    
    NSMutableArray *chooseArray;
    
    UITableView *infoTableView;
}
@end

@implementation ClaimPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择需要认领的职位";
    
    [self initItems];
    //初始化上半部分的提示
    [self initHeaderView];
    
    [self initTableView];
    
    listArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    [self initFooerView];
    
    chooseArray = [[NSMutableArray alloc] init];
    for (int i =0; i < [listArray count]; i++) {
        [chooseArray addObject:@"0"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"position_claim_close_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+20, imageInsets.bottom, imageInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
-(void)rightAction
{
    NSLog(@"关闭认领职位");
}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    ClaimPositionPromptView *promptView = [[ClaimPositionPromptView alloc] initWithFrame:CGRectMake(0, topBarheight, kWidth, [Util myYOrHeight:200])];
    [self.view addSubview:promptView];
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight-footerViewH, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.position = 4;
    //初始化按钮
    [footerView loadEditButton:3];
    [footerView setButton:[NSArray arrayWithObjects:@"20", nil] Enable:NO];
    //点击按钮的触发事件
    __weak ClaimPositionViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        ClaimPositionViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view addSubview:footerView];
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    switch (index) {
        case 10:
        {
            NSString *allString = isAll?@"1":@"0";
            for (int i =0; i < [chooseArray count]; i++) {
                [chooseArray replaceObjectAtIndex:i withObject:allString];
            }
            [infoTableView reloadData];
            [footerView setButton:[NSArray arrayWithObjects:@"20", nil] Enable:isAll];
        }
            break;
        case 20:
        {
            NSLog(@"认领职位");
        }
            break;
        case 30:
        {
             NSLog(@"下一步");
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 初始化tableView
-(void)initTableView
{
    float tableViewY = topBarheight + [Util myYOrHeight:200]+[Util myYOrHeight:10];
    infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, kWidth, kHeight-tableViewY-[Util myYOrHeight:45])];
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    infoTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:infoTableView];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"ClaimPositionTableViewCellID";
    ClaimPositionTableViewCell *cell = (ClaimPositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClaimPositionTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //全部选中按钮使用
    cell.tag = indexPath.row;
    NSString *isSelected;
    isSelected = [chooseArray objectAtIndex:indexPath.row];
    //加载全部选中按钮的状态
    [cell changeLocation:YES Selected:[isSelected intValue] ];
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Util myYOrHeight:47];
}
#pragma mark -ClaimPositionTableViewCellDelegate
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[NSArray arrayWithObjects:@"20", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后一个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"20", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}

@end

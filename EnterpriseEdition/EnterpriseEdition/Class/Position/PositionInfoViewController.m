//
//  PositionInfoViewController.m
//  职位详情
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionInfoViewController.h"
#import "PositionInfoTableViewCell0.h"
#import "PositionInfoTableViewCell1.h"
#import "PositionInfoTableViewCell2.h"
#import "FooterView.h"
#import "PositionOperationView.h"
#import "PositionSetUrgentView.h"
#import "OpenPositionViewController.h"
#import "CommendResumeForJobViewController.h"
@interface PositionInfoViewController ()
{
    UIView *headerView;
    FooterView *footerView;
    //操作具体视图 上线 删除 下线
    PositionOperationView *positonV;
    //设置急招的界面
    PositionSetUrgentView *urgentView;
}
@end

@implementation PositionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"职位详情";
    //设置提示信息的间距
    [self setTextViewParagraphStyle];
    
    //将提示视图隐藏
    promptBg.hidden = YES;
    
    //初始化item
    [self initItems];
    
    //初始化headerView
    [self initHeaderView];
    
    //初始化footerView
    [self initFooerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (positonV) {
        [positonV cancelView];
    }
    if (urgentView) {
        [urgentView cancelView];
    }
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellid=@"PositionInfoTableViewCell0ID";
        PositionInfoTableViewCell0 *cell = (PositionInfoTableViewCell0 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionInfoTableViewCell0" owner:self options:nil] lastObject];
        }
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        static NSString *cellid=@"PositionInfoTableViewCell1ID";
        PositionInfoTableViewCell1 *cell = (PositionInfoTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionInfoTableViewCell1" owner:self options:nil] lastObject];
        }
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellid=@"PositionInfoTableViewCell2ID";
        PositionInfoTableViewCell2 *cell = (PositionInfoTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionInfoTableViewCell2" owner:self options:nil] lastObject];
        }
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [Util myYOrHeight:70];
    }else if (indexPath.row == 1)
    {
        return [Util myYOrHeight:120];
    }else
    {
        return 300;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_reviewTips) {
        return [Util myYOrHeight:50];
    }else
    {
        return 0;
    }
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_reviewTips) {
        headerView.hidden = NO;
    }else
    {
        headerView.hidden = YES;
    }
    return headerView;
}
#pragma mark - 初始化headerView
-(void)initHeaderView
{
    CGRect frame = CGRectMake(0, 0, kWidth, [Util myYOrHeight:50]);
    headerView = [[UIView alloc] initWithFrame:frame];
    headerView.backgroundColor = Rgb(252, 248, 181, 1.0);
    frame = CGRectMake(20, 0, kWidth-40, [Util myYOrHeight:50]);
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = @"提示：xx当前职位未审核通过，原因是xxxx，请修改职位相关内容，并重新提交审核，谢谢合作。";
    lab.textColor = Rgb(173, 173, 123, 1.0);
    lab.font = [UIFont systemFontOfSize:13];
    lab.numberOfLines = 2;
    [headerView addSubview:lab];
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
    
    frame = CGRectMake(0, 0, 80, 30);
    UIButton *rightBt = [[UIButton alloc] initWithFrame:frame];
    [rightBt setTitle:@"查看简历" forState:UIControlStateNormal];
    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+20, titleInsets.bottom, titleInsets.right-20);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
   
    
}
-(void)leftAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction
{
    CommendResumeForJobViewController *resumeVC = [[CommendResumeForJobViewController alloc] init];
    resumeVC.isForPisition = YES;
    [self.navigationController pushViewController:resumeVC animated:YES];
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight-footerViewH, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    footerView.position = 2;
    //初始化按钮
    [footerView loadEditButton:3];
    //点击按钮的触发事件
    __weak PositionInfoViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        PositionInfoViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view addSubview:footerView];
}
#pragma mark - fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    switch (index) {
        case 10:
        {
            positonV = [[PositionOperationView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, 135)];
            __weak PositionInfoViewController *wself = self;
            positonV.operationPosition = ^(int index){
                PositionInfoViewController *sself = wself;
                [sself operationPosition:index];
            };
            [positonV showView:self.view];
        }
            break;
        case 20:
        {
            urgentView = [[PositionSetUrgentView alloc] initWithFrame:CGRectMake(0, 0, kWidth-40, 256)];
            __weak PositionInfoViewController *wself = self;
            urgentView.makeSurePositionUrgent = ^(int count){
                PositionInfoViewController *sself = wself;
                [sself setUrgent:count];
            };
            [urgentView showView:self.view];
        }
            break;
        case 30:
        {
            OpenPositionViewController *editVC = [[OpenPositionViewController alloc] init];
            editVC.isEditAgain = YES;
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 操作的具体触发事件
-(void)operationPosition:(int)index
{
    switch (index) {
        case 1://上线
            NSLog(@"上线");
            break;
        case 2://删除
            NSLog(@"删除");
            break;
        case 3://下线
            NSLog(@"下线");
            break;
            
        default:
            break;
    }
}
#pragma mark - 设置急招
-(void)setUrgent:(int)count
{
    NSLog(@" 设置急招 == %d",count);

}
-(void)setTextViewParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(0, 0, 0, 0.7)
                                 };
    proTextView.attributedText = [[NSAttributedString alloc] initWithString:proTextView.text attributes:attributes];
}

@end

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
    //数据字典
    NSMutableDictionary *infoDictionary;
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
//    if (YES) {
//        tableViewToTop.constant = promptBg.frame.size.height;
//    }

    
    //初始化item
    [self initItems];
    
    //初始化headerView
    [self initHeaderView];
    
    //初始化footerView
    [self initFooerView];
    
    //加载数据
//    [self requestPositonInfo];
    [self performSelector:@selector(requestPositonInfo) withObject:nil afterDelay:0.0];
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
        cell.isUrgentPosition = _isUrgent;
        [cell loadData:infoDictionary];
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
        [cell loadsubView:infoDictionary];
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
        [cell loadData:[infoDictionary objectForKey:@"job_description"]];
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
    resumeVC.jobId = _jobId;//@"118077";
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
            if (_isUrgent) {
                [Util showPrompt:@"该职位已经是急招职位"];
                return;
            }
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
            editVC.infoDic = infoDictionary;
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
        {
            [self batchDealWithPosition:_jobId Status:0];
       
        }
            break;
        case 2://删除
            NSLog(@"删除");
        {
            [self batchDealWithPosition:_jobId Status:-9];
        }
            break;
        case 3://下线
            NSLog(@"下线");
        {
            [self batchDealWithPosition:_jobId Status:1];

        
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 设置急招
-(void)setUrgent:(int)count
{
    NSLog(@" 设置急招 == %d",count);
    [self requestUrgentInfo:count];

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
#pragma mark - 加载数据
-(void)requestPositonInfo
{
    
    NSString *infoJson = [CombiningData getPositionInfo:[_jobId intValue]];
    NSLog(@"infoJson == %@",infoJson);
    [self showHUD:@"正在加载数据"];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                //加载首页数据
                NSArray *dataArr = [result objectForKey:@"data"];
                if ([dataArr count]>0) {
                    NSLog(@"dataArr== %@",dataArr);
                    infoDictionary = [NSMutableDictionary dictionaryWithDictionary:[dataArr firstObject]];
                }
                [dataTableView reloadData];
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"数据为空";
                }
                [self hideHUD];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alterView show];
                  NSLog(@"message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
           [self hideHUDFaild:@"服务器请求失败"];
            
            NSLog(@"%@",error);
        }
    };

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self leftAction];
}
-(void)batchDealWithPosition:(NSString*)idsString Status:(int)status
{
    [self showHUD:@"正在处理数据"];
    NSString *infoJson = [CombiningData positionManager:idsString Status:status];
    __block int tempstatus = status;
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"数据处理成功"];
                //仍然加载首页
                if (tempstatus == -9) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    if (tempstatus == 0) {
                        [infoDictionary setObject:@"正常" forKey:@"status"];
                    }else
                    {
                        [infoDictionary setObject:@"下线" forKey:@"status"];
                    }
                    [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                }
                
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"处理失败";
                }
                [self hideHUDFaild:message];
                NSLog(@"error message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    };
    
}
-(void)requestUrgentInfo:(int)maxCount
{
    [self showHUD:@"正在处理数据"];
    NSString *infoJson = [CombiningData setPositionUrgent:_jobId MaxCount:maxCount];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:@"数据处理成功"];
                //仍然加载首页
                _isUrgent = YES;
               [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                
                
            }else
            {
                NSString *message = [result objectForKey:@"message"];
                if ([message length]==0) {
                    message = @"处理失败";
                }
                [self hideHUDFaild:message];
                NSLog(@"error message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUDFaild:@"服务器请求失败"];
        }
    };
    
}

@end

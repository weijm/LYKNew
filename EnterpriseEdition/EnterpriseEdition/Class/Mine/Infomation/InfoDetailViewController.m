//
//  InfoDetailViewController.m
//  信息详情
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoDetailTableViewCell.h"
#import "InfoDetailTitleAndImgTableViewCell.h"

@interface InfoDetailViewController ()
{
    int infoType;//1为普通消息内容 2为通知内容
}
@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"信息详情";
    self.view.backgroundColor = kCVBackgroundColor;
    
    [self performSelector:@selector(requestInfo) withObject:nil afterDelay:0.0];
    

    if ([_infoStatus intValue]==0) {
        [self performSelector:@selector(requestSetMsg) withObject:nil afterDelay:0.0];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 编辑按钮
//-(void)initItems
//{
//    CGRect frame = CGRectMake(0, 0, 50, 30);
//    
//    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
//    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
//    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
//    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
//    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//    
//    
//}
-(void)leftAction
{
   
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
//    if (infoType ==1) {
//        return 2;
//    }else
//    {
//        return 1;
//    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"InfoDetailTableViewCell";
    InfoDetailTableViewCell *cell = (InfoDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoDetailTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    [cell loadsubView:_infoDictionary];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_infoDictionary==nil) {
        return 0;
    }

    float viewW = kWidth - [Util myXOrWidth:10]*2;
    NSString *content = [Util getCorrectString:[_infoDictionary objectForKey:@"content"]];
     CGSize theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    float bgH = theStringSize.height+[Util myYOrHeight:40];
    if (kIphone4||kIphone5) {
        bgH = theStringSize.height+65;
    }
    return theStringSize.height+bgH;
}
-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
#pragma mark - 请求消息详情
-(void)requestInfo
{
    [self showHUD:@"正在加载数据"];
    NSString *listJson = [CombiningData getMsgInfo:_infoId];
    
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                NSArray *dataArr = [result objectForKey:@"data"];
                if ([dataArr count]>0) {
                    _infoDictionary = [dataArr firstObject];
                    [dataTableView reloadData];
                }else
                {
                    [self hideHUDFaild:@"消息为空"];
                }
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
//将该消息置为已读
-(void)requestSetMsg
{
    NSString *listJson = [CombiningData setMsg:_infoId Type:1];
    
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:listJson httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                
            }else
            {
            }
        }else
        {
        }
    }];
}
@end

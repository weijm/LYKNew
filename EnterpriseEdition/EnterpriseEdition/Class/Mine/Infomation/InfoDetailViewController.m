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
    self.title = @"信息内容";
    self.view.backgroundColor = kCVBackgroundColor;
    
    [self initItems];
    
    infoType = [[_infoDictionary objectForKey:@"type"] intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    
}
-(void)leftAction
{
   
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (infoType ==1) {
        return 2;
    }else
    {
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (infoType == 1 && indexPath.row == 0) {
        static NSString *cellId = @"InfoDetailTitleAndImgTableViewCellID";
        InfoDetailTitleAndImgTableViewCell *cell = (InfoDetailTitleAndImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoDetailTitleAndImgTableViewCell" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        [cell loadsubView:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellId = @"InfoDetailTableViewCell";
        InfoDetailTableViewCell *cell = (InfoDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoDetailTableViewCell" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        cell.infoType = infoType;
        [cell loadsubView:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (infoType == 1) {
        if (indexPath.row == 0) {
            return [Util myYOrHeight:275];
        }else
        {
            return [Util myYOrHeight:133];
        }
    }else
    {
        return [Util myYOrHeight:100];
    }
}
@end

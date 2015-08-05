//
//  SearchResumeViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/20.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SearchResumeViewController.h"
#import "UIButton+Custom.h"
#import "FooterView.h"
#import "FiltratePickerView.h"
#import "CustomSearchBar.h"

#define kSearchBarRect CGRectMake(0,22,kWidth,40)
@interface SearchResumeViewController ()
{
    UISearchBar *customSearchBar;
    
    UIButton_Custom *rightBt;
    
    FooterView *footerView;
    
    FiltrateView *filtrateView;
    
    UIView *headerView;
    
}
@end

@implementation SearchResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    [self initHeaderView];
    //初始化编辑按钮
    [self initItems];
    //初始化搜索条
    [self initSearchBar];
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    //设置tableView
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorColor = [UIColor clearColor];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化搜索条
//初始化导航条
-(void)initSearchBar
{
    customSearchBar = [[UISearchBar alloc] initWithFrame:kSearchBarRect];
    //添加的searchBar标记
    customSearchBar.delegate = self;
    //设置searchBar的背景图片
    customSearchBar.backgroundImage = [Util imageWithColor:[UIColor clearColor]];
    //searchBar的提示文字
    if (kIphone6) {
        customSearchBar.placeholder = @"搜索                                                      ";
    }else if (kIphone6plus)
    {
        customSearchBar.placeholder = @"搜索                                                              ";
    }else
    {
        customSearchBar.placeholder = @"搜索                                         ";
    }
    
    //设置textFiled的背景
    [customSearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"resume_search_bg"] forState:UIControlStateNormal];
    [customSearchBar setImage:[UIImage imageNamed:@"homepage_search_bt"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [customSearchBar valueForKey:@"_searchField"];
    if (searchField) {
        searchField.textColor = [UIColor whiteColor];
    }
    
    customSearchBar.barStyle = UIBarStyleBlackTranslucent;
    //添加到页面上
    self.navigationItem.titleView = customSearchBar;
}

#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 15, 30);
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-10, imageInsets.bottom, imageInsets.right+10);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    frame = CGRectMake(0, 0, 30, 30);
    rightBt = [[UIButton_Custom alloc] initWithFrame:frame];
    [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
    imageInsets = rightBt.imageEdgeInsets;
    rightBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left+10, imageInsets.bottom, imageInsets.right-10);
    rightBt.titleLabel.font = [UIFont systemFontOfSize:14];
    UIEdgeInsets titleInsets = rightBt.titleEdgeInsets;
    rightBt.titleEdgeInsets = UIEdgeInsetsMake(titleInsets.top, titleInsets.left+10, titleInsets.bottom, titleInsets.right-10);
    [rightBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
-(void)leftAction
{
    if(footerView)
    {
        [footerView cancelFooterView];
    }
    [customSearchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction
{
    if (rightBt.specialMark ==0) {//出现选择按钮
        [rightBt setTitle:@"取消" forState:UIControlStateNormal];
        [rightBt setImage:nil forState:UIControlStateNormal];
        rightBt.specialMark = 1;
        //显示底部的编辑按钮
        [self initFooerView];
        
        //编辑的时候 搜索条不可点
        customSearchBar.userInteractionEnabled = NO;
        
    }else
    {//隐藏选中按钮
        [rightBt setTitle:@"" forState:UIControlStateNormal];
        [rightBt setImage:[UIImage imageNamed:@"home_edit_btn"] forState:UIControlStateNormal];
        rightBt.specialMark = 0;
        //取消底部视图
        [footerView cancelFooterView];
        //取消编辑的时候 搜索条可点
        customSearchBar.userInteractionEnabled = YES;
   
    }
    [dataTableView reloadData];
}
#pragma mark - headerView
-(void)initHeaderView
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [Util myYOrHeight:35])];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = kCVBackgroundColor;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, [Util myYOrHeight:35]-4.5, kWidth, 0.5)];
    line.backgroundColor = Rgb(150, 204, 243, 0.7);
    [headerView addSubview:line];
    
    float btW = [Util myXOrWidth:150];
    UIButton *filtrateBt = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-btW)/2, 3, btW, [Util myYOrHeight:35]-5)];
    [filtrateBt setTitle:@"综合筛选" forState:UIControlStateNormal];
    [filtrateBt setTitleColor:Rgb(76, 80, 83, 1.0) forState:UIControlStateNormal];
    [filtrateBt addTarget:self action:@selector(filtrateAction) forControlEvents:UIControlEventTouchUpInside];
    filtrateBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:filtrateBt];
    
    UIView *imgbg = [[UIView alloc] initWithFrame:CGRectMake(filtrateBt.frame.origin.x+btW-[Util myXOrWidth:48], 3, 30, filtrateBt.frame.size.height)];
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, (filtrateBt.frame.size.height-7)/2, 4, 7)];
    arrowImg.image = [UIImage imageNamed:@"resume_filtrate_arrow"];
    [imgbg addSubview:arrowImg];
    [headerView addSubview:imgbg];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"SearchResumeId";
    SearchResumeTableViewCell *cell = (SearchResumeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResumeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    //加载视图数据
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    [cell loadSearchResumeData:dic];
    //全部选中按钮使用
    cell.tag = indexPath.row;
    NSString *isSelected;
    if (rightBt.specialMark==1) {
        isSelected = [chooseArray objectAtIndex:indexPath.row];
    }else
    {
        isSelected = @"0";
    }
    //加载全部选中按钮的状态
    [cell changeLocation:rightBt.specialMark Selected:[isSelected intValue] ];
    //取消点击cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeaderViewH+ kMiddleViewH + [Util myYOrHeight:3];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([dataArray count]!=0) {
        if (rightBt.specialMark==1) {
            return [Util myYOrHeight:11];
        }else
        {
            return [Util myYOrHeight:35];
        }
        
    }else
    {
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([dataArray count]!=0) {
        if (rightBt.specialMark==1) {
            headerView.hidden = YES;
        }else
        {
            headerView.hidden = NO;
        }
        return headerView;
    }else
    {
        return nil;
    }
    
}

#pragma -mark - 综合筛选的事件
-(void)filtrateAction
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    customSearchBar.userInteractionEnabled = NO;
    CGRect frame = CGRectMake(0, 0, kWidth, kHeight-topBarheight);
    filtrateView = [[FiltrateView alloc] initWithFrame:frame];
    filtrateView.delegate = self;
    //根据所选简历分类 加载的筛选内容不同
    [filtrateView changeTitleArray:2];
    [self.view addSubview:filtrateView];

}
#pragma mark - 综合筛选FiltrateViewDelegate
-(void)didSelectedRow:(int)row
{
    if (row == 0) {
        return;
    }
    CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
    int style = 0;
    if(row == 5)//地区
    {
        style = 2;
    }else if(row == 3||row==0)//专业 此处修改[self showConditions: Content:]随着修改
    {
        style = 1;
    }
    FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
    pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
        [self showConditions:index Content:dictionary];
    };
    pickerView.categoryType = 2;
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
    customSearchBar.userInteractionEnabled = YES;
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

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //取消键盘
    [self cancelKey];
    //搜索内容
    [self getData];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    [self addEditBg];
    return YES;
}
#pragma mark-添加和取消键盘的事件
-(void)addEditBg
{
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIView *bg = [[UIView alloc] initWithFrame:frame];
    bg.backgroundColor = [UIColor lightGrayColor];
    bg.alpha = 0.3;
    bg.tag = 1000;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
    [bg addGestureRecognizer:tap];
    [self.view addSubview:bg];
}
-(void)cancelKey
{
    UIView *bg = [self.view viewWithTag:1000];
    if (bg) {
        [bg removeFromSuperview];
    }
    [customSearchBar resignFirstResponder];
    customSearchBar.text = nil;
}
#pragma mark - 初始化footerView
-(void)initFooerView
{
    float footerViewH = kFOOTERVIEWH;
    CGRect frame = CGRectMake(0, kHeight, kWidth, footerViewH);
    footerView = [[FooterView alloc] initWithFrame:frame];
    //初始化按钮
    [footerView loadEditButton:2];
    //设置除了全选按钮可点击 其余按钮不可点击
    [footerView setButton:[NSArray arrayWithObjects:@"200", nil]Enable:NO];
    //点击按钮的触发事件
    __weak SearchResumeViewController *wself = self;
    footerView.chooseFooterBtAction = ^(NSInteger index,BOOL isAll){
        SearchResumeViewController *sself = wself;
        [sself chooseAction:index isChooseAll:isAll];
    };
    [self.view.window addSubview:footerView];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = footerView.frame;
        frame.origin.y = kHeight - kFOOTERVIEWH;
        footerView.frame = frame;
    }];
}
#pragma mark - headerView和fooerView上的选择不同按钮的触发事件
-(void)chooseAction:(NSInteger)index isChooseAll:(BOOL)isAll
{
    switch (index) {
        case 100:
        {
            NSString *allString = isAll?@"1":@"0";
            for (int i =0; i < [chooseArray count]; i++) {
                [chooseArray replaceObjectAtIndex:i withObject:allString];
            }
            [dataTableView reloadData];
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:isAll];
        }
            break;
        case 200:
            NSLog(@"选中简历类型 2 取消收藏选中的简历");
            break;
        
        default:
            break;
    }

}
#pragma mark - SearchResumeTableViewCellDelegate
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected
{
    [chooseArray replaceObjectAtIndex:index withObject:isSelected];
    //判断是否有选中的简历 进而控制收藏选中简历按钮 和 删除选中按钮是否可点
    for (int i= 0; i< [chooseArray count]; i++) {
        NSString *isSelected = [chooseArray objectAtIndex:i];
        if ([isSelected intValue] == 1) {
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:YES];
            break;
        }else if (i == [chooseArray count]-1)
        {
            //后两个按钮不可点击
            [footerView setButton:[NSArray arrayWithObjects:@"200", nil] Enable:NO];
            //全选按钮取消选中状态
            [footerView revertChooseBtByIndex:10];
        }
    }
}
#pragma mark - 获取数据
-(void)getData
{
    dataArray = [[NSMutableArray alloc] init];
    NSString *jobStr = @"软件工程师";
    
    for (int i =0; i < 6; i++) {
        NSString *job = [NSString stringWithFormat:@"%@%d",jobStr,i];
        NSString *time = [NSString stringWithFormat:@"08-%d",i+10];
        NSString *name = [NSString stringWithFormat:@"张晓%d",i];
        NSString *age = [NSString stringWithFormat:@"%d",i];
        NSString *money = [NSString stringWithFormat:@"%d-%d",500*(i+1),800*(i+1)];
        NSString *exp = (i%3==0)?@"有工作经验":@"";
        NSString *urgent = @"0";
        NSString *colledted = @"0";
        NSString *download = @"0";
        
        [dataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:job,@"job",urgent,@"urgent",colledted,@"collected",download,@"download",time,@"time",name,@"name",@"女",@"sex",@"UI设计师",@"selfjob",age,@"age",@"本科",@"record",money,@"money",@"艺术设计",@"professional",@"中国传媒大学",@"school",exp,@"experience",nil]];
    }
    
    [dataTableView reloadData];
    chooseArray = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
    for (int i=0; i< [dataArray count]; i++) {
        [chooseArray addObject:@""];
    }
    if ([dataArray count]>0) {
         self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
@end

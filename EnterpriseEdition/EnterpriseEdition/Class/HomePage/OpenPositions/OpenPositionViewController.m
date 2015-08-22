//
//  OpenPositionViewController.m
//  发布职位
//
//  Created by wjm on 15/7/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "OpenPositionViewController.h"
#import "PositionObject.h"


@interface OpenPositionViewController ()
{
    //标题数组
    NSArray *titleArray;
    //编辑的内容数组
    NSMutableArray *contentArray;
    //取消键盘的手势
    UITapGestureRecognizer *cancelKeyTap;
}
@end

@implementation OpenPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kCVBackgroundColor;
    if (_isEditAgain) {
        self.title = @"编辑职位";
        promptTotop.constant = topBarheight;
    }else
    {
        self.title = @"发布职位";
        if (!_fromPositionManager) {
            //导航条的颜色
            [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.translucent = NO;
        }else
        {
            promptTotop.constant = topBarheight;
        }
        
    }
    
    titleArray = [NSArray arrayWithContentsOfFile:[Util getBundlePath:@"position.plist"]];
    contentArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[titleArray count]; i++) {
        [contentArray addObject:@" "];
    }
    
    lineWidth.constant = 0.5;
    
//    [[LocationViewController shareInstance] startLocation];
    [self changeInfoInLocation];
    
    NSString * iidStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kEntStatus];
    if ([iidStatus intValue]==1) {
        commitBt.enabled = NO;
        commitBt.alpha = 0.5;
    }else
    {
        commitBt.enabled = YES;
        commitBt.alpha = 1;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (titleArray) {
        titleArray = nil;
    }
    if (contentArray) {
        contentArray = nil;
    }
    if (cancelKeyTap) {
        cancelKeyTap = nil;
    }
    // Dispose of any resources that can be recreated.
}
#pragma mark - 转化编辑数据
-(void)changeInfoInLocation
{
    NSDictionary *dic = _infoDic;
    if (dic==nil) {
        return;
    }
    NSArray *keyArray = [NSArray arrayWithObjects:@"title",@"industry_name",@"job_type_name",@"need_count",@"work_type",[NSArray arrayWithObjects:@"salary_min",@"salary_max", nil],[NSArray arrayWithObjects:@"city_name_1",@"city_name_2",@"city_name_3", nil],@"address",@"job_description",@"certificate_type",@"work_exp_type",@"department",@"benefit",nil];
    for (int i =0; i < [keyArray count]; i++)
    {
        NSObject *obj = [keyArray objectAtIndex:i];
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *keyString = (NSString*)obj;
            NSObject *contentobj = [Util getCorrectString:[dic objectForKey:keyString]];
            if ([contentobj isKindOfClass:[NSString class]]) {
                NSString *content = (NSString*)contentobj;
                if ([content length]>0) {
                    NSMutableDictionary *dictionary = nil;
                    if (i==1||i==2||i==4||i==9||i==10) {
                        dictionary = [NSMutableDictionary dictionaryWithDictionary:[self getIdsFromContentByWeb:content Index:i]];
                        [dictionary setObject:content forKey:@"content"];
                    }else{
                        dictionary = [NSMutableDictionary dictionary];
                        [dictionary setObject:content forKey:@"content"];
                    }
                    
                    [contentArray replaceObjectAtIndex:i withObject:dictionary];
                }
            }else
            {
                NSArray *contArray = (NSArray*)contentobj;
                NSMutableString *content = [NSMutableString string];
                for (int i =0; i < [contArray count]; i++) {
                    [content appendString:[contArray objectAtIndex:i]];
                }
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                [dictionary setObject:content forKey:@"content"];
                [contentArray replaceObjectAtIndex:i withObject:dictionary];
            }
            
            
        }else if ([obj isKindOfClass:[NSArray class]])
        {
            if (i==6) {
                NSString *content = nil;
                NSString *str1 = [Util getCorrectString:[dic objectForKey:@"city_name_1"]];
                NSString *str2 = [Util getCorrectString:[dic objectForKey:@"city_name_2"]];
                if ([str2 isEqualToString:str1]) {
                    content = [NSString stringWithFormat:@"%@%@",str1,[Util getCorrectString:[dic objectForKey:@"city_name_3"]]];
                }else
                {
                    content = [NSString stringWithFormat:@"%@%@%@",str1,str2,[Util getCorrectString:[dic objectForKey:@"city_name_3"]]];
                }
                //获取对应的id
                NSDictionary *contentDictionry = [NSDictionary dictionaryWithObjectsAndKeys:str1,@"province",str2,@"city",[dic objectForKey:@"city_name_3"],@"district", nil];
                
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self getIdByContent:contentDictionry Index:5]];
                [dictionary setObject:content forKey:@"content"];
                [contentArray replaceObjectAtIndex:i withObject:dictionary];
            }else if (i == 5)
            {
                NSString *content = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"salary_min"],[dic objectForKey:@"salary_max"]];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content",[dic objectForKey:@"salary_min"],@"salary_min",[dic objectForKey:@"salary_max"],@"salary_max", nil];
                [contentArray replaceObjectAtIndex:i withObject:dictionary];
           
            }
           
            
        }
        
    }
    [dataTableView reloadData];
}

#pragma mark - Items按钮触发事件
-(void)leftAction
{
    if (_isEditAgain) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    [[LocationViewController shareInstance] stopLocation];
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"PositionCellId";
    PositionTableViewCell *cell = (PositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PositionTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    [cell initData:[titleArray objectAtIndex:indexPath.row]];
    [cell loadContent:[contentArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==8) {
        return [Util myYOrHeight:100];
    }else
    {
        return [Util myYOrHeight:33];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0 &&indexPath.row!=3&&indexPath.row!=7&&indexPath.row!=8&&indexPath.row!=11&&indexPath.row != 12) {
        [dataTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //取消键盘
        [self cancelKey];
        
        CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
        int style = 0;
        int row;
        
        switch (indexPath.row) {//与pickerView中的内容对应
            case 1:
                row = 7;//行业
                break;
            case 2:
                row = 0;//职位名称
                break;
            case 4:
                row = 4;//职位类型
                break;
            case 5:
                row =2;//薪资范围
                break;
            case 6:
                row =5;//工作地点
                break;
            case 9:
                row = 1;//学历要求
                break;
            case 10:
                row = 6;//工作经验
                break;
            default:
                break;
        }
        
        
        if(row == 5)//地区
        {
            style = 2;
        }else if(row==0||row==7)//专业 此处修改[self showConditions: Content:]随着修改
        {
            style = 1;
        }
        FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
        pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
            [self showConditions:index Content:dictionary];
        };
        if(row == 0)
        {
            pickerView.categoryType = 1;
        }
        [pickerView loadData:row];
        [pickerView showInView:self.view];
    }
   
}
#pragma mark -将pickerView上选中的内容显示到界面
-(void)showConditions:(int)row Content:(NSDictionary*)dictionary
{
    int index = 0;
    //从picker的row转换为tableView的index
    switch (row) {//与pickerView中的内容对应
        case  7:
            index =1;
            break;
        case 0:
            index = 2;
            break;
        case 4:
            index = 4;
            break;
        case 2:
            index =5;
            break;
        case 5:
            index = 6;
            break;
        case 1:
            index = 9;
            break;
        case 6:
            index = 10;
            break;
        default:
            break;
    }

    if (row == 5 || row ==0 ||row == 7) {//地区 此处可以查询对应的id
         NSDictionary *idsDic = [self getIdByContent:dictionary Index:row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:idsDic];
        
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
        [contentArray replaceObjectAtIndex:index withObject:dic];
    }else
    {//其他
        if (row == 2) {//薪资
            NSDictionary *dic = [self getMaxAnMinSalary:dictionary];
           [contentArray replaceObjectAtIndex:index withObject:dic];
        }else
        {
            [contentArray replaceObjectAtIndex:index withObject:dictionary];
        }
        
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath , nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 将pickerView选取的内容转换为id
-(NSMutableDictionary*)getIdByContent:(NSDictionary*)dictionary Index:(int)row
{
    NSMutableDictionary *idsDic = nil;
    switch (row) {
        case 0://职位名称
        {
            idsDic = [CombiningData getJobTypeIDsByContent:dictionary];
        }
            break;
        case 5://省市区
        {
            idsDic = [CombiningData getCityIDsByContent:dictionary];
        }
            break;
        case 7://所属行业
        {
            idsDic = [CombiningData getIndustryIDsByContent:dictionary];
        }
            break;
            
        default:
            break;
    }
    return idsDic;
}
#pragma mark - PositionTableViewCellDelegate
-(void)setEditView:(UIView*)_editView
{
    //编辑视图textField之间的切换时 会将前一个的内容保存
    [self editTextFiledAndCancelKey:NO];
    //最后一行的TextView与其他的TextField之间切换时 会将最后一行的内容保存
    [self editTextViewAndCancelKey:NO];
    editView = _editView;
    if (cancelKeyTap==nil) {
        cancelKeyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKey)];
        [self.view addGestureRecognizer:cancelKeyTap];
    }

    //让编辑第8行第11行和12行的时候 编辑框可见
    if(editView.tag == 11||editView.tag == 12||editView.tag == 8)
    {
        float offY = 0;
        if (editView.tag==12) {
            offY = [Util myYOrHeight:200];
        }else if (editView.tag == 11)
        {
            offY = [Util myYOrHeight:160];
        }
        else
        {
            offY = [Util myYOrHeight:80];
        }
        [self tableViewAnimation:offY];
        
    }else
    {
        [self tableViewAnimation:0];
    }
    
    [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:editView.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void)tableViewAnimation:(float)offY
{
    //对于其他的编辑框还原dataTableView位置
    if (dataTableViewToBottom.constant !=0) {
        float viewY = dataTableViewToBottom.constant;
        [UIView animateWithDuration:0.5 animations:^{
            dataTableViewToBottom.constant = 0;
            dataTableViewToTop.constant = dataTableViewToTop.constant+viewY;
        }];
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            dataTableViewToBottom.constant = offY;
            dataTableViewToTop.constant = dataTableViewToTop.constant-offY;
        }];
   
    }

}
//点击界面上取消键盘
-(void)cancelKey
{
    //编辑视图textField在键盘取消时 会将内容保存
    [self editTextFiledAndCancelKey:YES];
    
    //取消最后一行职位描述的时候 将内容保存
    [self editTextViewAndCancelKey:YES];
    
    if (cancelKeyTap) {
        [self.view removeGestureRecognizer:cancelKeyTap];
        cancelKeyTap = nil;
    }
    editView = nil;
    
    //还原dataTableView位置
    [self tableViewAnimation:0];

}
-(void)editTextFiledAndCancelKey:(BOOL)isCancel
{
    if (editView&&[editView isKindOfClass:[UITextField class]]) {
        UITextField *tempView = (UITextField*)editView;
        if (isCancel) {
            [tempView resignFirstResponder];
        }
        NSString *content = tempView.text;
        if ([content length]>0) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content", nil];
            [contentArray replaceObjectAtIndex:tempView.tag withObject:dictionary];
        }else
        {
            [contentArray replaceObjectAtIndex:tempView.tag withObject:@"0"];
        }
    }
}
-(void)editTextViewAndCancelKey:(BOOL)isCancel
{
    if ([editView isKindOfClass:[UITextView class]]) {
        UITextView *tempView = (UITextView*)editView;
        if (isCancel) {
            [tempView resignFirstResponder];
        }
        NSString *content = tempView.text;
        
        if ([content length]>0) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content", nil];
            [contentArray replaceObjectAtIndex:tempView.tag withObject:dictionary];
        }else
        {
            [contentArray replaceObjectAtIndex:tempView.tag withObject:@" "];
        }
    }
}
#pragma mark - 将保存数据到本地
- (IBAction)saveDataAction:(id)sender {
    
    BOOL isFull = [self checkInfo];
    if (isFull) {//当填写的信息完整并有效时 保存到服务器
        if(_isEditAgain)
        {//从详情进入编辑
            [self requestSaveOrCommitInfo:kSavePositionInfo Prompt:@"保存" jobId:[_infoDic objectForKey:@"id"] ActionType:@"1"];
            
        }else
        {//新建保存
            [self requestSaveOrCommitInfo:kSavePositionInfo Prompt:@"保存" jobId:@"0" ActionType:@"1"];
        }
        
    }
}
#pragma mark - 提交审核发布的职位
- (IBAction)commitAction:(id)sender {
    BOOL isFull = [self checkInfo];
    if (isFull) {//当填写的信息完整并有效时 提交到服务器
        if (_isEditAgain) {
            [self requestSaveOrCommitInfo:kSavePositionInfo Prompt:@"提交" jobId:[_infoDic objectForKey:@"id"] ActionType:@"2"];
        }else
        {
            [self requestSaveOrCommitInfo:kSavePositionInfo Prompt:@"提交" jobId:@"0" ActionType:@"2"];
        }
        
    }
}
#pragma mark - 请求服务器
-(void)requestSaveOrCommitInfo:(NSString*)type Prompt:(NSString*)ptomptString jobId:(NSString*)jID  ActionType:(NSString*)actionType
{
    DLog(@"contentArray  == %@",contentArray);
    NSString *jsonString = [CombiningData addPosition:contentArray Type:type PositionId:jID ActionType:actionType];
    [self showHUD:[NSString stringWithFormat:@"正在%@",ptomptString]];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost finishDidBlock:^(id result, NSError *error) {
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUDWithComplete:[NSString stringWithFormat:@"%@成功",ptomptString]];
                //返回上一页
                [self performSelector:@selector(leftAction) withObject:nil afterDelay:1.5];
                
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
            }
        }else
        {
            [self hideHUD];
            [self showAlertView:@"服务器请求失败"];
        }
    }];
//    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:jsonString httpMethod:HttpMethodPost WithSSl:nil];
//    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
//        if (result!=nil) {
//            if ([[result objectForKey:@"result"] intValue]>0) {
//                [self hideHUDWithComplete:[NSString stringWithFormat:@"%@成功",ptomptString]];
//                //返回上一页
//                [self performSelector:@selector(leftAction) withObject:nil afterDelay:1.5];
//                
//            }else
//            {
//                [self hideHUDFaild:[result objectForKey:@"message"]];
//            }
//        }else
//        {
//            [self hideHUD];
//            [self showAlertView:@"服务器请求失败"];
//        }
//        
//    };

}
#pragma mark - 验证所填写的信息
-(BOOL)checkInfo
{
    NSInteger count = [contentArray count];
    BOOL isFull = YES;
    for (int i =0; i< count; i++) {
        NSObject *obj = [contentArray objectAtIndex:i];
        NSDictionary *dic = [titleArray objectAtIndex:i];
        NSString *title = [dic objectForKey:@"title"];
        if ([obj isKindOfClass:[NSString class]]&&i!=1&&i!=9&&i!=10&&i!=11&&i!=12) {
            [Util showPrompt:[NSString stringWithFormat:@"%@ 不能为空",title]];
            isFull = NO;
            break;
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *contentDic = (NSDictionary*)obj;
            NSString *content = [contentDic objectForKey:@"content"];
            if (i==0||i==7||i==11||i==8||i==12) {
                if ([Util stringContainsEmoji:content]) {
                    [Util showPrompt:[NSString stringWithFormat:@"%@ 不符合规则，请重新输入",title]];
                    isFull = NO;
                    break;
                }

            }
            if (i==0||i==11||i==7) {
                if ([content length]>30) {
                    [Util showPrompt:[NSString stringWithFormat:@"%@ 不能超过30字",title]];
                    isFull = NO;
                    break;
                }
            }else if (i==8)
            {
                if ([content length]>1000) {
                    [Util showPrompt:[NSString stringWithFormat:@"%@ 不能超过1000字",title]];
                    isFull = NO;
                    break;
                }
            }else if (i==12)
            {
                if ([content length]>50) {
                    [Util showPrompt:[NSString stringWithFormat:@"%@ 不能超过50字",title]];
                    isFull = NO;
                    break;
                }
            }else if (i==3)
            {
                int needCount = [content intValue];
                if (![Util isPureInt:content]) {
                    [Util showPrompt:[NSString stringWithFormat:@"请输入实际需要招聘人数"]];
                    
                }else
                {
                    if (needCount >255) {
                        [Util showPrompt:[NSString stringWithFormat:@"招聘人数不可以超过255"]];
                        isFull = NO;
                        break;
                    }
                }
            }
        }
    }
    return isFull;

}
#pragma mark - 将薪资进行转化
-(NSMutableDictionary*)getMaxAnMinSalary:(NSDictionary*)dictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSArray *salaryArr = [[dictionary objectForKey:@"content"] componentsSeparatedByString:@"-"];
    if ([salaryArr count]>0) {
        [dic setObject:[salaryArr firstObject] forKey:@"salary_min"];
        [dic setObject:[salaryArr lastObject] forKey:@"salary_max"];
    }else
    {
        [dic setObject:@"20000" forKey:@"salary_min"];
        [dic setObject:@"60000" forKey:@"salary_max"];
    }
    return dic;
}
//将字符串转换id
-(NSMutableDictionary*)getIdsFromContentByWeb:(NSString*)content Index:(int)index
{
    NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
    if (index == 1) {//所属行业
        NSArray *array = [content componentsSeparatedByString:@" "];
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        if ([array count]>1) {
            [dic setObject:[array firstObject] forKey:@"industry_id0"];
            [dic setObject:[array lastObject] forKey:@"industry_id1"];
            newDic = [self getIdByContent:dic Index:7];
            return newDic;
        }else
        {
            int indexId= [[PositionObject shareInstance] getIndustryIdsByName:content];
            [dic setObject:[NSNumber numberWithInt:indexId] forKey:@"industry_id1"];
            return dic;
        }

    }else if (index==2)//职位名称
    {
        NSArray *array = [content componentsSeparatedByString:@" "];
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        if ([array count]>1) {
            [dic setObject:[array firstObject] forKey:@"job_type_id0"];
            [dic setObject:[array lastObject] forKey:@"job_type_id1"];
            newDic = [self getIdByContent:dic Index:0];
            return newDic;
        }else
        {
            int indexId= [[PositionObject shareInstance] getJobTypeIdsByName:content];
            [dic setObject:[NSNumber numberWithInt:indexId] forKey:@"job_type_id1"];
            return dic;
        }

    }else if (index == 4)//职位类型
    {
        NSString *compangSize = [CombiningData getJObTypeId:[Util getCorrectString:content]];
        [newDic setObject:compangSize forKey:@"selectedId"];
        return newDic;
    }else if (index == 9)//学历要求
    {
        NSString *compangSize = [CombiningData getCerId:[Util getCorrectString:content]];
        [newDic setObject:compangSize forKey:@"selectedId"];
        return newDic;
    }else if (index == 10)//工作经验
    {
        NSString *compangSize = [CombiningData getExpId:[Util getCorrectString:content]];
        [newDic setObject:compangSize forKey:@"selectedId"];
        return newDic;
    }
    return nil;
}
@end

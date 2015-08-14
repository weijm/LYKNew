//
//  EnterpriseInfoViewController.m
//  企业资料
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EnterpriseInfoViewController.h"
#import "EnterpriseContactViewController.h"
#import "SDWebImageManager.h"

@interface EnterpriseInfoViewController ()
{
    //标题数组
    NSArray *titleArray;
    //编辑的内容数组
    NSMutableArray *contentArray;
    //取消键盘的手势
    UITapGestureRecognizer *cancelKeyTap;
    //当前编辑的视图
    UIView *editView;
    //区分营业执照 企业logo图片的变量
    int imgType;
}
@end

@implementation EnterpriseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"填写企业资料";
    
    if (kIphone6plus) {
        proHeight.constant = proHeight.constant+2;
        proWidth.constant = proWidth.constant+2;
    }
    
    titleArray = [NSArray arrayWithContentsOfFile:[Util getBundlePath:@"enterpriseInfo.plist"]];
    contentArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[titleArray count]; i++) {
        [contentArray addObject:@"0"];
    }
    
    [self performSelector:@selector(getEntInfoFromWeb) withObject:nil afterDelay:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置提示字体颜色
-(void)setPromptTextColor
{
    NSString *string = promptLab.text;
    NSRange range = [string rangeOfString:@"4008-907-977"];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:Rgb(2, 139, 230, 1.0)
     
                          range:range];
    promptLab.attributedText = attributedStr;
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //带有图片的cell
    if (indexPath.row == 5||indexPath.row == 8) {
        static NSString *cellid=@"EnterpriseImgTableViewCellID";
        EnterpriseImgTableViewCell *cell = (EnterpriseImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EnterpriseImgTableViewCell" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        [cell initData:[titleArray objectAtIndex:indexPath.row]];
        [cell loadImg:[contentArray objectAtIndex:indexPath.row]];

        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    //纯文字编辑的cell
    static NSString *cellid=@"EnterpriseBaseTableViewCellID";
    EnterpriseBaseTableViewCell *cell = (EnterpriseBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EnterpriseBaseTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tag = indexPath.row;
    [cell initData:[titleArray objectAtIndex:indexPath.row] Content:[contentArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==6) {
        return [Util myYOrHeight:70];
    }else if (indexPath.row == 5||indexPath.row==8){
        NSObject *obj = [contentArray objectAtIndex:indexPath.row];
        if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = (NSDictionary*)obj;
            NSString *filePath = [dic objectForKey:@"content"];
            if ([filePath length]>0) {
                return [Util myYOrHeight:100];
            }
        }

        
        return [Util myYOrHeight:50];
    }
    else
    {
        return [Util myYOrHeight:33.5];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1 ||indexPath.row==2||indexPath.row==3||indexPath.row==7) {
        [infoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //取消键盘
        [self cancelKey];
        
        CGRect frame = CGRectMake(0, kHeight, kWidth, 258);
        int style = 0;
        int row;
        
        switch (indexPath.row) {//与pickerView中的内容对应
            case 1:
                row = 7;
                break;
            case 2:
                row = 8;
                break;
            case 3:
                row = 5;
                break;
            case 7:
                row = 9;
                break;
            default:
                break;
        }
        
        
        if(row == 5)//地区
        {
            style = 2;
        }else if(row==7)//专业 此处修改[self showConditions: Content:]随着修改
        {
            style = 1;
        }
        FiltratePickerView *pickerView = [[FiltratePickerView alloc] initWithFrame:frame pickerStyle:style];
        pickerView.didSelectedPickerRow = ^(int index,NSDictionary *dictionary){
            [self showConditions:index Content:dictionary];
        };
        
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
        case 8:
            index = 2;
            break;
        case 5:
            index = 3;
            break;
        case 9:
            index =7;
            break;
        default:
            break;
    }
    
    if (row == 5 ||row == 7) {//地区 此处可以查询对应的id
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
        [contentArray replaceObjectAtIndex:index withObject:dictionary];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath , nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 将pickerView选取的内容转换为id
-(NSMutableDictionary*)getIdByContent:(NSDictionary*)dictionary Index:(int)row
{
    NSMutableDictionary *idsDic = nil;
    switch (row) {
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

#pragma mark - EnterpriseBaseTableViewCellDelegate
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
    
    //让编辑第10行和11行的时候 编辑框可见
    if(editView.tag == 6||editView.tag == 9)
    {
        if (infoTableViewToBottom.constant ==44) {
            [UIView animateWithDuration:0.5 animations:^{
                infoTableViewToBottom.constant = 200;
                infoTableViewToTop.constant = infoTableViewToTop.constant-200;
            }];
        }
    }else
    {//对于其他的编辑框还原dataTableView位置
        if (infoTableViewToBottom.constant !=44) {
            [UIView animateWithDuration:0.5 animations:^{
                infoTableViewToBottom.constant = 44;
                infoTableViewToTop.constant = infoTableViewToTop.constant+200;
            }];
        }
        
    }
    
    [infoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:editView.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    if (infoTableViewToBottom.constant !=44) {
        [UIView animateWithDuration:0.5 animations:^{
            infoTableViewToBottom.constant = 44;
            infoTableViewToTop.constant = infoTableViewToTop.constant+200;
        }];
    }
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
    if (editView&&[editView isKindOfClass:[UITextView class]]) {
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
            [contentArray replaceObjectAtIndex:tempView.tag withObject:@"0"];
        }
    }
}
#pragma mark -EnterpriseImgTableViewCellDelegate
-(void)addPicture:(int)index
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取",@"拍张新照片", nil];
    imgType = index;
    [sheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet tag == %ld",actionSheet.tag);
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"从相册选取");
            [self addOfAlbum];
        }
            break;
        case 1:
        {
            NSLog(@"拍张新照片");
            [self addOfCamera];
        }
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark - 添加照片的方式
- (void) addOfCamera
{
    ;
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void) addOfAlbum
{
    //for iphone
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:NULL];
    }
    
}

#pragma mark –
#pragma mark - Camera View Delegate Methods
//点击相册中的图片或者照相机照完后点击use 后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image;
        if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){//如果打开相册
            [picker dismissViewControllerAnimated:YES completion:NULL];//关掉相册
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            
            CGSize imagesize = image.size;
            imagesize.height = image.size.height*0.5;
            imagesize.width = image.size.width*0.5;
            
            image = [self imageWithImage:image scaledToSize:imagesize];
        }
        else{//照相机
            [picker dismissViewControllerAnimated:YES completion:NULL];//关掉照相机
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            
            CGSize imagesize = image.size;
            imagesize.height = image.size.height*0.5;
            imagesize.width = image.size.width*0.5;
            
            image = [self imageWithImage:image scaledToSize:imagesize];
            
            // 保存照片到相册的方法
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
//        [self saveImgInLoaction:image];
        //把选中的图片添加到界面中
        [self performSelector:@selector(uploadImg:)
                   withObject:image
                   afterDelay:0.0];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];//关掉照相机
        [picker dismissViewControllerAnimated:YES completion:NULL];//关掉相册
        [Util showPrompt:@"不能上传视频作为证书图片，请重新选择"];
    }
}
// 保存照片到相册
- (void)image:(UIImage *)image didFinishSavingWithError:
(NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error) {
        
        NSLog(@"保存成功");
    } else {
        
        NSLog(@"保存失败 : %@",[error localizedDescription]);
    }
}
//将图片保存到本地
-(void)saveImgInLoaction:(UIImage*)image
{
    //将图片保存到本地
    NSLog(@"imgtype == %d",imgType);
    NSString *fileName = (imgType==5)?kLicense:kLogin;
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@",[Util getFileDir],fileName];
    NSData *imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:imgPath atomically:YES];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:imgPath,@"content", nil];
    [contentArray replaceObjectAtIndex:imgType withObject:dictionary];
    
    [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:imgType inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - 保存方法
- (IBAction)saveEnterpriseInfo:(id)sender {
    NSLog(@"content == %@",contentArray);
    BOOL isFull = [self checkInfo];
    if (isFull) {//信息填写完整时执行
        [self performSelector:@selector(requestSaveEntInfo) withObject:nil afterDelay:0.0];
    }
   
}
-(BOOL)checkInfo
{
    NSInteger count = [contentArray count];
    BOOL isFull = YES;
    for (int i =0; i< count; i++) {

        NSObject *obj = [contentArray objectAtIndex:i];
        if ([obj isKindOfClass:[NSString class]]) {
            NSDictionary *dic = [titleArray objectAtIndex:i];
            if (i==7||i==8||i==9) {//非必填项
                continue;
            }
            
            NSString *title = [dic objectForKey:@"title"];
            [Util showPrompt:[NSString stringWithFormat:@"%@ 不能为空",title]];
            isFull = NO;
            break;
        }else
        {
            if (i==9) {
                NSDictionary *dic = (NSDictionary*)obj;
                BOOL isRight = [Util checkWebSite:[dic objectForKey:@"content"]];
                if (!isRight) {
                    [Util showPrompt:@"网址格式不正确"];
                    break;
                }
            }
        }
    }
    return isFull;

}
#pragma mark - 请求服务器
//保存到服务器
-(void)requestSaveEntInfo
{
    [self showHUD:@"正在保存"];
    NSMutableArray *resultArray = [self getRow2AndRow7Id];
    NSString *infoJson = [CombiningData uploadEntInfo:resultArray];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                if (_entStatus==0) {
                    
                    EnterpriseContactViewController *contactVC = [[EnterpriseContactViewController alloc] init];
                    [self.navigationController pushViewController:contactVC animated:YES];
                }else{//正常 审核通过
                    [self hideHUD];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
                NSLog(@"error message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUD];
            [self showAlertView:@"服务器请求失败"];
        }
        
    };
}
//将企业性质和人数规模转化id
-(NSMutableArray*)getRow2AndRow7Id
{
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:contentArray];
    for (int i = 0; i< [contentArray count]; i++) {
        if (i ==2||i==7) {
            NSObject *obj = [resultArray objectAtIndex:i];
            NSDictionary *dic = (NSDictionary*)obj;
            NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
            if (i==2) {
                [newDic setObject:[dic objectForKey:@"selectedId"] forKey:@"content"];
                [resultArray replaceObjectAtIndex:i withObject:newDic];
            }else
            {
                if ([obj isKindOfClass:[NSDictionary class]]) {//填写了内容
                    int companyNumber = [[dic objectForKey:@"selectedId"] intValue]+1;
                    [newDic setObject:[NSString stringWithFormat:@"%d",companyNumber] forKey:@"content"];
                    [resultArray replaceObjectAtIndex:i withObject:newDic];
                
                }else
                {//没有填写内容
                    [newDic setObject:@"0" forKey:@"content"];
                    [resultArray replaceObjectAtIndex:i withObject:newDic];
                }
                
            }
        }
    }
    return resultArray;

}
//获取企业资料
-(void)getEntInfoFromWeb
{
    [self showHUD:@"正在加载数据"];
    NSString *infoJson = [CombiningData getMineInfo:kGetEntInfo];
    //请求服务器
    [AFHttpClient asyncHTTPWithURl:kWEB_BASE_URL params:infoJson httpMethod:HttpMethodPost WithSSl:nil];
    [AFHttpClient sharedClient].FinishedDidBlock = ^(id result,NSError *error){
        if (result!=nil) {
            if ([[result objectForKey:@"result"] intValue]>0) {
                [self hideHUD];
                NSArray *dataArray = [result objectForKey:@"data"];
                NSLog(@"dataArray== %@",dataArray);
                [self dealWithData:dataArray];
            }else
            {
                [self hideHUDFaild:[result objectForKey:@"message"]];
                NSLog(@"error message == %@",[result objectForKey:@"message"]);
            }
        }else
        {
            [self hideHUD];
            [self showAlertView:@"服务器请求失败"];
        }
        
    };
}
//将获取的数据进行处理
-(void)dealWithData:(NSArray*)array
{
    NSDictionary *dic = nil;
    if ([array count]>0) {
        dic = [array firstObject];
    }else
    {
        return;
    }
    NSArray *keyArray = [NSArray arrayWithObjects:@"company_name",@"industry_id",@"ent_type",[NSArray arrayWithObjects:@"city_id_1",@"city_id_2",@"city_id_3", nil],@"address",@"licence_url",@"intro",@"company_size",@"logo_url",@"web_site", nil];
    for (int i =0; i < [keyArray count]; i++)
    {
        NSObject *obj = [keyArray objectAtIndex:i];
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *keyString = (NSString*)obj;
            NSString *content = [Util getCorrectString:[dic objectForKey:keyString]];
            
            if ([content length]>0) {
                NSMutableDictionary *dictionary = nil;
                if (i==1||i==2||i==7) {
                    dictionary = [NSMutableDictionary dictionaryWithDictionary:[self getIdsFromContentByWeb:content Index:i]];
                    [dictionary setObject:content forKey:@"content"];
                }else{
                    dictionary = [NSMutableDictionary dictionary];
                    [dictionary setObject:content forKey:@"content"];
                }
                
                [contentArray replaceObjectAtIndex:i withObject:dictionary];
            }

        }else if ([obj isKindOfClass:[NSArray class]])
        {
            NSString *content = nil;
            NSString *str1 = [Util getCorrectString:[dic objectForKey:@"city_id_1"]];
            NSString *str2 = [Util getCorrectString:[dic objectForKey:@"city_id_2"]];
            if ([str2 isEqualToString:str1]) {
                content = [NSString stringWithFormat:@"%@%@",str1,[dic objectForKey:@"city_id_3"]];
            }else
            {
                content = [NSString stringWithFormat:@"%@%@%@",str1,str2,[dic objectForKey:@"city_id_3"]];
            }
            //获取对应的id
            NSDictionary *contentDictionry = [NSDictionary dictionaryWithObjectsAndKeys:str1,@"city1",str2,@"city2",[dic objectForKey:@"city_id_3"],@"city3", nil];
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self getIdByContent:contentDictionry Index:5]];
            [dictionary setObject:content forKey:@"content"];
            [contentArray replaceObjectAtIndex:i withObject:dictionary];
            
        }
        
    }
    NSLog(@"getContentArray == %@",contentArray);
    [infoTableView reloadData];
}
//上传图片
-(void)uploadImg:(UIImage*)image
{
    [self showHUD:@"正在上传图片"];

    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [AFHttpClient uploadWithURLAttachment:imageData];
    [AFHttpClient sharedClient].UploadFileStatus = ^(BOOL isSuccess ,NSDictionary *dictionary){
        if (isSuccess) {
            [self hideHUDWithComplete:@"上传成功"];
            NSString *imgUrl = [dictionary objectForKey:@"data"];
            NSLog(@"imgUrl == %@",imgUrl);
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"content", nil];
            //获取原来的图片路径
            NSDictionary *oldDic = [contentArray objectAtIndex:imgType];
            if ([oldDic isKindOfClass:[NSDictionary class]]&&[[oldDic objectForKey:@"content"] length]>0) {
                [SDWebImageManager.sharedManager.imageCache removeImageForKey:[oldDic objectForKey:@"content"]];
            }
            
            [contentArray replaceObjectAtIndex:imgType withObject:dictionary];
            
            [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:imgType inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            
        }else
        {
            [self hideHUDFaild:[dictionary objectForKey:@"data"]];
        }
    };
}
//将字符串转换id
-(NSMutableDictionary*)getIdsFromContentByWeb:(NSString*)content Index:(int)index
{
    NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
    if (index == 1) {
        NSArray *array = [content componentsSeparatedByString:@" "];
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        if ([array count]>0) {
            [dic setObject:[array firstObject] forKey:@"industry_id0"];
            [dic setObject:[array lastObject] forKey:@"industry_id1"];
            newDic = [self getIdByContent:dic Index:7];
            return newDic;
        }
    }else if (index==2)//企业性质
    {
        NSString *compangType = [CombiningData getEntType:content];
        [newDic setObject:compangType forKey:@"selectedId"];
        return newDic;
    }else if (index == 7)//人数规模
    {
        NSString *compangSize = [CombiningData getCompanySize:[Util getCorrectString:content]];
        [newDic setObject:compangSize forKey:@"selectedId"];
        return newDic;
    }
    return nil;
}
@end

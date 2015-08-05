//
//  EnterpriseInfoViewController.m
//  企业资料
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EnterpriseInfoViewController.h"
#import "EnterpriseContactViewController.h"

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
    [cell initData:[titleArray objectAtIndex:indexPath.row]];
    [cell loadContent:[contentArray objectAtIndex:indexPath.row]];
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
            if ([Util isExistsFile:filePath]) {
                return [Util myYOrHeight:80];
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
        [contentArray replaceObjectAtIndex:index withObject:dic];
    }else
    {//其他
        [contentArray replaceObjectAtIndex:index withObject:dictionary];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [infoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath , nil] withRowAnimation:UITableViewRowAnimationNone];
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
                NSLog(@"dataTableViewToBottom.constant = 100");
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
        [self saveImgInLoaction:image];
        //把选中的图片添加到界面中
//        [self performSelector:@selector(saveImage:)
//                   withObject:image
//                   afterDelay:0.5];
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
//    BOOL isFull = [self checkInfo];
//    if (isFull) {//信息填写完整时执行
        EnterpriseContactViewController *contactVC = [[EnterpriseContactViewController alloc] init];
        [self.navigationController pushViewController:contactVC animated:YES];
//    }
   
}
-(BOOL)checkInfo
{
    NSInteger count = [contentArray count];
    BOOL isFull = YES;
    for (int i =0; i< count; i++) {
        NSObject *obj = [contentArray objectAtIndex:i];
        if ([obj isKindOfClass:[NSString class]]) {
            if (i==7||i==8||i==9) {//非必填项
                continue;
            }
            NSDictionary *dic = [titleArray objectAtIndex:i];
            NSString *title = [dic objectForKey:@"title"];
            [Util showPrompt:[NSString stringWithFormat:@"%@ 不能为空",title]];
            isFull = NO;
            break;
        }
    }
    return isFull;

}
@end

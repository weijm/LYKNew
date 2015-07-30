//
//  EnterpriseContactViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EnterpriseContactViewController.h"
#import "ReferenceView.h"
#import "ClaimPositionViewController.h"

@interface EnterpriseContactViewController ()
{
    //标题数组
    NSArray *titleArray;
    //编辑的内容数组
    NSMutableArray *contentArray;
    //取消键盘的手势
    UITapGestureRecognizer *cancelKeyTap;
    //当前编辑的视图
    UIView *editView;
    
    IBOutlet NSLayoutConstraint *proWidth;
    IBOutlet NSLayoutConstraint *proHeight;
}
@end

@implementation EnterpriseContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (kIphone6plus) {
        proHeight.constant = proHeight.constant+2;
        proWidth.constant = proWidth.constant+2;
    }
    self.title = @"请填写企业联系人";
    [self setPromptTextColor];
    
    titleArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"联系人姓名",@"title",@"请和授权书中的名字保持一致",@"placeholder", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"联系电话/座机",@"title",@"如:13901012345或010-68881111转123",@"placeholder", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"负责人授权书",@"title",@"请和授权书中的名字保持一致",@"placeholder", nil], nil];
    infoTableView.tableFooterView = [self getFooterView];
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
    if (indexPath.row == 2) {
        static NSString *cellid=@"EnterpriseImgTableViewCellID";
        EnterpriseImgTableViewCell *cell = (EnterpriseImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EnterpriseImgTableViewCell" owner:self options:nil] lastObject];
        }
        cell.tag = indexPath.row;
        [cell initData:[titleArray objectAtIndex:indexPath.row]];
        
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
    cell.cellType = 1;
    [cell initData:[titleArray objectAtIndex:indexPath.row]];
    [cell loadContent:[contentArray objectAtIndex:indexPath.row]];
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 2 || indexPath.row ==1){
        return [Util myYOrHeight:50];
    }
    else
    {
        return [Util myYOrHeight:35];
    }
}
#pragma mark - 请参考的示例视图
-(UIView*)getFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];
    footerView.userInteractionEnabled = YES;
    ReferenceView *referenceView = [[ReferenceView alloc] initWithFrame:CGRectMake((kWidth-320)/2, 0, 320, 300)];
    referenceView.lookExampleAction = ^{
        [self lookUpExample];
    };
    [footerView addSubview:referenceView];
    return footerView;

}
//查看样例的触发事件
-(void)lookUpExample
{
    NSLog(@"查看样例");
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
    
}
-(void)editTextFiledAndCancelKey:(BOOL)isCancel
{
    if ([editView isKindOfClass:[UITextField class]]) {
        UITextField *tempView = (UITextField*)editView;
        if (isCancel) {
            [tempView resignFirstResponder];
        }
        NSString *content = tempView.text;
        if ([content length]>0) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content,@"content", nil];
            [contentArray replaceObjectAtIndex:tempView.tag withObject:dictionary];
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
        }
    }
}
#pragma mark -EnterpriseImgTableViewCellDelegate
-(void)addPicture:(int)index
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取",@"拍张新照片", nil];
    sheet.tag = index;
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
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        //把选中的图片添加到界面中
        //        [self performSelector:@selector(saveImage:)
        //                   withObject:image
        //                   afterDelay:0.5];
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];//关掉照相机
        [picker dismissViewControllerAnimated:YES completion:NULL];//关掉相册
        //        [self showAlertView:@"不能上传视频作为证书图片，请重新选择"];
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
#pragma mark - 保存并提交
- (IBAction)saveAndCommit:(id)sender {
    NSLog(@"保存并提交 企业联系人");
    ClaimPositionViewController *claimPVC = [[ClaimPositionViewController alloc] init];
    [self.navigationController pushViewController:claimPVC animated:YES];
}
@end

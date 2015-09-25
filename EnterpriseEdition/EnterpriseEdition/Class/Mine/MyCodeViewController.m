//
//  MyCodeViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/9/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyCodeViewController.h"
#import "MyTableViewCell0.h"
#import "QrCodeGenerated.h"
@interface MyCodeViewController ()

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的二维码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellid=@"MyTableViewCell0ID";
        MyTableViewCell0 *cell = (MyTableViewCell0 *)[tableView dequeueReusableCellWithIdentifier:cellid];//（寻找标识符为cellid并且没被用到的cell用于重用）
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell0" owner:self options:nil] lastObject];
        }
        cell.isInQRCode = YES;
        [cell loadSubView:_infoDic];
        //取消点击cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellid=@"CellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        if (indexPath.row ==1) {
            cell.backgroundColor = Rgb(230, 244, 253, 1.0);
        }else
        {
            float imgw = [Util myXOrWidth:200];
            float imgY = [Util myYOrHeight:70];
            if (kIphone4) {
                imgY = 35;
            }
            NSString *uidStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUID];
            UIImageView *qrcodeImg = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-imgw)/2, imgY, imgw, imgw)];
            qrcodeImg.image = [[QrCodeGenerated sharedInstance] generatedQrCodeImageByContent:[NSString stringWithFormat:@"EZZ_RES:%@",uidStr]];
//             qrcodeImg.image = [[QrCodeGenerated sharedInstance] generatedQrCodeImageByContent:[NSString stringWithFormat:@"EZZ_RES:117467"]];
            
            [cell.contentView addSubview:qrcodeImg];
            
       
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [Util myYOrHeight:78];
    }else if (indexPath.row ==1)
    {
        return [Util myYOrHeight:5];
    }else
    {
        
        return kHeight-[Util myYOrHeight:78]-[Util myYOrHeight:10];
    }
}
@end

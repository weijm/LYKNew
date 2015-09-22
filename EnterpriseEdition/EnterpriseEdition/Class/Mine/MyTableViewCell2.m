//
//  MyTableViewCell2.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "MyTableViewCell2.h"

@implementation MyTableViewCell2

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        itemIconWdith.constant = itemIconWdith.constant+2;
        itemIconHeight.constant = itemIconHeight.constant +3;
        
        arrowWidth.constant = arrowWidth.constant+1;
        arrowHeight.constant = arrowHeight.constant+1;
        
        titleLab.font = [UIFont systemFontOfSize:16];
        phoneLab.font = [UIFont systemFontOfSize:19];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubView:(NSString*)msgCount
{
    int index = (int)self.tag;
    iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"my_cell_icon%d",index]];
    switch (index) {
        case 2:
            titleLab.text = @"我的二维码";
            break;
        case 3:
        {
            UILabel *tempLab = (UILabel*)[iconImg viewWithTag:10];
            if (tempLab) {
                [tempLab removeFromSuperview];
            }
            titleLab.text = @"信       息";
            NSString *newCount = [Util getCorrectString:msgCount];
            if ([newCount intValue]>0) {
//                CGRect iconFrame = iconImg.frame;
                float labX = itemIconWdith.constant-6;
                float labY = 0;
                float labH = 13;
                float labW = 13;
                if ([newCount intValue]>=10&&[newCount intValue]<100) {
                    labW = 13;
                    
                }else if ([newCount intValue]>=100)
                {
                    labW = 18;
                    newCount = @"99+";
                }
                UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
                countLab.text = newCount;
                countLab.font = [UIFont systemFontOfSize:9];
                countLab.backgroundColor = [UIColor redColor];
                countLab.textColor = [UIColor whiteColor];
                countLab.textAlignment = NSTextAlignmentCenter;
                countLab.tag = 10;
                [iconImg addSubview:countLab];
                countLab.clipsToBounds = YES;
                countLab.layer.cornerRadius = 6.5;
                countLab.layer.masksToBounds = YES;
            }
        }
            
            break;
        case 4:
            titleLab.text = @"版本说明";
            break;
        case 5:
            titleLab.text = @"客服电话";
            phoneLab.hidden = NO;
            break;
        case 6:
            titleLab.text = @"修改密码";
            break;
       

            
        default:
            break;
    }
    
    if (index == 5) {
        phoneLab.hidden = NO;
    }else
    {
        phoneLab.hidden = YES;
    }
    if (index == 6) {
        lineToLeft.constant = 0;
    }else
    {
        lineToLeft.constant = 55;
    }
}
@end

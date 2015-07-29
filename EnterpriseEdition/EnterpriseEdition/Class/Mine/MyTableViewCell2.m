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
        itemIconWdith.constant = itemIconWdith.constant*1.5;
        itemIconHeight.constant = itemIconHeight.constant *1.5;
        
        arrowWidth.constant = arrowWidth.constant*1.5;
        arrowHeight.constant = arrowHeight.constant*1.5;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubView
{
    int index = (int)self.tag;
    iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"my_cell_icon%d",index]];
    switch (index) {
        case 2:
            titleLab.text = @"信    息";
            break;
        case 3:
            titleLab.text = @"版本说明";
            break;
        case 4:
            titleLab.text = @"客服电话";
            phoneLab.hidden = NO;
            break;
        case 5:
            titleLab.text = @"修改密码";
            break;
            
        default:
            break;
    }
    
    if (index == 4) {
        phoneLab.hidden = NO;
    }else
    {
        phoneLab.hidden = YES;
    }
    if (index == 5) {
        lineToLeft.constant = 0;
    }else
    {
        lineToLeft.constant = 55;
    }
}
@end

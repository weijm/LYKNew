//
//  IdentityTableViewCell.m
//  身份信息Cell
//
//  Created by wjm on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "IdentityTableViewCell.h"

@implementation IdentityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    addressToTop.constant = 5.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)lookUpInfo:(id)sender {
    self.lookIdentityInfo();
    
    littleInfoBg.hidden = YES;
    infoBg.hidden = NO;
}
-(void)showInfo:(BOOL)isShow
{
    if (isShow) {
        littleInfoBg.hidden = YES;
        infoBg.hidden = NO;
    }else
    {
        littleInfoBg.hidden = NO;
        infoBg.hidden = YES;
    }
}
@end

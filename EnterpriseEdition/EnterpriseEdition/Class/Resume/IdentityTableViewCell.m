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
-(void)loadData:(NSDictionary*)dic
{
    if (dic != nil) {
        phoneLab.text = [Util getCorrectString:[dic objectForKey:@"contact_no"]];
        mailLab.text = [Util getCorrectString:[dic objectForKey:@"email"]];
        addressLab.text = [NSString stringWithFormat:@"%@%@%@",[Util getCorrectString:[dic objectForKey:@"city_name_1"]],[Util getCorrectString:[dic objectForKey:@"city_name_2"]],[Util getCorrectString:[dic objectForKey:@"city_name_3"]]];
    }

}
@end

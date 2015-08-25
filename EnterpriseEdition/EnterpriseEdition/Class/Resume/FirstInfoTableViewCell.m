//
//  FirstInfoTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FirstInfoTableViewCell.h"

@implementation FirstInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)lookUpInfo:(id)sender {
    if (infoDic == nil) {
        [Util showPrompt:@"身份信息为空"];
        return;
    }
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
    [self showInfo:YES];
    infoDic = dic;
    if (dic != nil) {
        phoneLab.text = [Util getCorrectString:[dic objectForKey:@"contact_no"]];
        mailLab.text = [Util getCorrectString:[dic objectForKey:@"email"]];
        addressLab.text = [NSString stringWithFormat:@"%@%@%@",[Util getCorrectString:[dic objectForKey:@"city_name_1"]],[Util getCorrectString:[dic objectForKey:@"city_name_2"]],[Util getCorrectString:[dic objectForKey:@"city_name_3"]]];
        politicalLab.text = [self getPoliticalString:[[dic objectForKey:@"political_type"] intValue]];
    }
}
-(NSString*)getPoliticalString:(int)index
{
    if (index==0) {
        return @"群众";
    }else if (index == 1)
    {
        return @"团员";
    }else if (index == 2)
    {
        return @"党员";
    }else if (index == 3)
    {
        return @"其他";
    }else //-1
    {
        return @"未填";
    }
    
}
-(void)loadRetaimCount:(NSString*)downloadCount
{
    if (downloadCount!=nil) {
        showDownloadCountLab.text = [NSString stringWithFormat:@"剩余%@次",downloadCount];
        showDownloadCountLab.hidden = NO;
    }else
    {
        showDownloadCountLab.hidden = YES;
    }
    
}

@end

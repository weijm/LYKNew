//
//  CertificateTableViewCell.m
//  荣誉证书cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CertificateTableViewCell.h"
#import "TitleView.h"
#import "CertificateView.h"

@implementation CertificateTableViewCell

- (void)awakeFromNib {
    // Initialization code
    titleView.titleLab.text = @"求职证书";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadCertificate:(NSArray*)array
{
    for (int i = 0; i < [array count]; i++)
    {
        float height = 90;
        CGRect frame = CGRectMake(0, height*i, infobg.frame.size.width, height);
        CertificateView *view = [[CertificateView alloc] initWithFrame:frame];
        [infobg addSubview:view];
    }

}
@end

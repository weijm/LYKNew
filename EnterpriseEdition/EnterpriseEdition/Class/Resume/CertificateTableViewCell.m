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
-(void)loadCertificate:(NSObject*)obj
{
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray*)obj;
        NSInteger count = [array count];
        if (count>0) {
            for (UIView *vie in [infobg subviews]) {
                if (vie) {
                    [vie removeFromSuperview];
                }
            }
            for (int i = 0; i < count; i++)
            {
                NSDictionary *dic = [array objectAtIndex:i];
                float height = 90;
                if ([[dic objectForKey:@"certify_url"] length]>0) {
                    height = 90;
                }
                
                CGRect frame = CGRectMake(0, height*i, infobg.frame.size.width, height);
                CertificateView *view = [[CertificateView alloc] initWithFrame:frame];
                [view loadData:dic];
                [infobg addSubview:view];
            }
        }else
        {
            emptyView.hidden = NO;
            infobg.hidden = YES;
        }
        
    }else
    {
        emptyView.hidden = NO;
        infobg.hidden = YES;
    }
    

}
@end

//
//  CertificateView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CertificateView.h"
#import "UIImageView+WebCache.h"

@implementation CertificateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIView *containerView = [[[UINib nibWithNibName:@"CertificateView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
//        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        containerView.frame = newFrame;
//        [self addSubview:containerView];
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBig)];
//        [self addGestureRecognizer:tapGesture];
//        
    }
    return self;
}
-(void)loadData:(NSDictionary*)dictionary
{
    titleLab.text = [dictionary objectForKey:@"certify_title"];
    pictureUrl = [dictionary objectForKey:@"certify_url"];
    if ([pictureUrl length]>0) {
        bottomBg.hidden = NO;
        [cerImg sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage imageNamed:@"resume_cer_default"]];
    }else
    {
        cerImg.image = [UIImage imageNamed:@"resume_cer_default"];
    }
}
-(void)loadSubView:(NSDictionary*)dictionary
{
    if (dictionary != nil) {
        CGRect frame = CGRectMake(0, 0, 65, 18);
        UILabel *titLab = [[UILabel alloc] initWithFrame:frame];
        titLab.backgroundColor = [UIColor clearColor];
        titLab.text = @"证书名称:";
        titLab.font = [UIFont systemFontOfSize:14];
        titLab.textColor = Rgb(0, 0, 0, 1);
        [self addSubview:titLab];
        
        frame = CGRectMake(frame.size.width, frame.origin.y, kWidth-80-65, frame.size.height);
        UILabel *nameLab = [[UILabel alloc] initWithFrame:frame];
        nameLab.backgroundColor = [UIColor clearColor];
        nameLab.text = [dictionary objectForKey:@"certify_title"];
        nameLab.font = [UIFont systemFontOfSize:12];
        nameLab.textColor = Rgb(0, 0, 0, 0.7);
        [self addSubview:nameLab];
        
         pictureUrl = [dictionary objectForKey:@"certify_url"];
        if ([pictureUrl length]>0) {
            frame = CGRectMake(0, frame.origin.y+frame.size.height+5, 50, 50);
            cerImgView = [[UIImageView alloc] initWithFrame:frame];
            cerImgView.userInteractionEnabled = YES;
            [cerImgView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage imageNamed:@"resume_cer_default"]];
            [self addSubview:cerImgView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBig)];
            [cerImgView addGestureRecognizer:tapGesture];
        }

    }
}
-(void)lookBig
{
    if ([pictureUrl length]>0) {
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[cerImgView convertRect: cerImgView.bounds toView:window];
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        bg.alpha = 0;
        bg.backgroundColor = [UIColor blackColor];
        bg.tag = 10000;
        [self.window addSubview:bg];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction)];
        [bg addGestureRecognizer:tap];
        UIImageView *bigView = [[UIImageView alloc] initWithFrame:rect];
        [bigView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage imageNamed:@"resume_cer_default"]];
        bigView.tag = 10001;
        bigView.userInteractionEnabled = YES;
        [self.window addSubview:bigView];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(10, (kHeight-(kWidth-20))/2, kWidth-20, kWidth-20);
            bigView.frame = frame;
            bg.alpha = 0.5;
            
        }];
    }
}
-(void)closeAction
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[cerImgView convertRect: cerImgView.bounds toView:window];
    UIView *bg = [self.window viewWithTag:10000];
    UIImageView *bigView = (UIImageView *)[self.window viewWithTag:10001];
    [UIView animateWithDuration:0.5 animations:^{
        bg.alpha = 0.0;
        bigView.frame = rect;
    } completion:^(BOOL finished) {
        [bigView removeFromSuperview];
        [bg removeFromSuperview];
    }];
    
    
}
-(float)getLabWidth
{
    if (kIphone6plus) {
        return 290;
    }else if (kIphone6)
    {
        return 280;
    }
    else
    {
        return 222;
    }
}
-(float)getLabFontSize
{
    return 13;
}
@end

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
        UIView *containerView = [[[UINib nibWithNibName:@"CertificateView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBig)];
        [self addGestureRecognizer:tapGesture];
        
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

-(void)lookBig
{
    if ([pictureUrl length]>0) {
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[cerImg convertRect: cerImg.bounds toView:window];
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
    CGRect rect=[cerImg convertRect: cerImg.bounds toView:window];
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
@end

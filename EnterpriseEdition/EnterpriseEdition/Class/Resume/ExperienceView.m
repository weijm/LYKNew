//
//  ExperienceView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ExperienceView.h"
#import "UIImageView+WebCache.h"

@implementation ExperienceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIView *containerView = [[[UINib nibWithNibName:@"ExperienceView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
//        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        containerView.frame = newFrame;
//        [self addSubview:containerView];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)loadData:(NSDictionary*)dictioanry
{
    if (dictioanry!=nil&&[dictioanry isKindOfClass:[NSDictionary class]]) {
        timeLab.text = [NSString stringWithFormat:@"%@--%@",[dictioanry objectForKey:@"start_date"],[dictioanry objectForKey:@"end_date"]];
        orgLab.text = [dictioanry objectForKey:@"company_name"];
        positionLab.text = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictioanry objectForKey:@"job_type_name"]],[dictioanry objectForKey:@"industry_name"]];
        NSString *jobContent = [dictioanry objectForKey:@"job_description"];
        contentLab.text = [jobContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        CGSize theStringSize = [contentLab.text sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
        if (theStringSize.width <200) {
//            contentLab.frame = CGRectMake(contentLab.frame.origin.x+10, contentLab.frame.origin.y+20, theStringSize.width, theStringSize.height);
        }else
        {
            contentLab.frame = CGRectMake(contentLab.frame.origin.x, contentLab.frame.origin.y, theStringSize.width, theStringSize.height);
        }
        //添加实习证明的图片
        NSString *imgUrl = [Util getCorrectString:[dictioanry objectForKey:@"certify_url"]];
        if ([imgUrl length]>0) {
            botBgToBottom.constant = 65;
             UIImageView *cerImg = [[UIImageView alloc] initWithFrame:CGRectMake(bottomBg.frame.origin.x, 60+contentLab.frame.size.height, 50, 50)];
            [cerImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"resume_cer_default"]];
            [self addSubview:cerImg];
        }
    }
}
-(void)loadSubView:(NSDictionary*)dictionary
{
    if (dictionary!=nil&&[dictionary isKindOfClass:[NSDictionary class]])
    {
        for (UIView *view in [self subviews]) {
            [view removeFromSuperview];
        }
        CGRect frame = CGRectMake(0, 0, [self getLabWidth], 18);
        UILabel *dataLab = [[UILabel alloc] initWithFrame:frame];
        dataLab.backgroundColor = [UIColor clearColor];
        dataLab.text = [NSString stringWithFormat:@"%@--%@",[dictionary objectForKey:@"start_date"],[dictionary objectForKey:@"end_date"]];
        dataLab.font = [UIFont systemFontOfSize:12];
        dataLab.textColor = Rgb(0, 0, 0, 0.7);
        [self addSubview:dataLab];
        
        frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
        UILabel *comNameLab = [[UILabel alloc] initWithFrame:frame];
        comNameLab.backgroundColor = [UIColor clearColor];
        comNameLab.text = [dictionary objectForKey:@"company_name"];
        comNameLab.font = [UIFont systemFontOfSize:14];
        comNameLab.textColor = Rgb(0, 0, 0, 1);
        [self addSubview:comNameLab];
        
        frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
        UILabel *posLab = [[UILabel alloc] initWithFrame:frame];
        posLab.backgroundColor = [UIColor clearColor];
        posLab.text = [NSString stringWithFormat:@"%@ | %@",[Util getCorrectString:[dictionary objectForKey:@"job_type_name"]],[dictionary objectForKey:@"industry_name"]];
        posLab.font = [UIFont systemFontOfSize:12];
        posLab.textColor = Rgb(0, 0, 0, 0.7);
        [self addSubview:posLab];
        
        frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
        UILabel *contTilLab = [[UILabel alloc] initWithFrame:frame];
        contTilLab.backgroundColor = [UIColor clearColor];
        contTilLab.text = @"工作内容：";
        contTilLab.font = [UIFont systemFontOfSize:14];
        contTilLab.textColor = Rgb(0, 0, 0, 1);
        [self addSubview:contTilLab];
        
        NSString *jobContent = [[dictionary objectForKey:@"job_description"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
         CGSize theStringSize = [jobContent sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake([self getLabWidth], MAXFLOAT)];
        frame = CGRectMake(0, frame.origin.y+frame.size.height, frame.size.width, theStringSize.height);
        UILabel *contLab = [[UILabel alloc] initWithFrame:frame];
        contLab.backgroundColor = [UIColor clearColor];
        contLab.text = jobContent;
        contLab.font = [UIFont systemFontOfSize:13];
        contLab.textColor = Rgb(0, 0, 0, 0.7);
        contLab.numberOfLines = 10000;
        [self addSubview:contLab];
        
        //添加实习证明的图片
        pictureUrl = [Util getCorrectString:[dictionary objectForKey:@"certify_url"]];
        if ([pictureUrl length]>0) {
            frame = CGRectMake(0, frame.origin.y+frame.size.height+5, 50, 50);
            cerImg = [[UIImageView alloc] initWithFrame:frame];
            cerImg.userInteractionEnabled = YES;
            [cerImg sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage imageNamed:@"resume_cer_default"]];
            [self addSubview:cerImg];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBig)];
            [cerImg addGestureRecognizer:tapGesture];
        }

        
    }
    
    
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

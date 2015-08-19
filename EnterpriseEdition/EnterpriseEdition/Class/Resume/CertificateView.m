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
    }
    return self;
}
-(void)loadData:(NSDictionary*)dictionary
{
    titleLab.text = [dictionary objectForKey:@"certify_title"];
    NSString *imgUrl = [dictionary objectForKey:@"certify_url"];
    if ([imgUrl length]>0) {
        bottomBg.hidden = NO;
        [cerImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    }else
    {
//        bottomBg.hidden = YES;
    }
}
@end

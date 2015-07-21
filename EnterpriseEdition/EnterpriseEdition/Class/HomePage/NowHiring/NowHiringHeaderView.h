//
//  NowHiringHeaderView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/20.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
#import "Session.h"

@interface NowHiringHeaderView : UIView
{
    UIView *subbg;
    IBOutlet UIView *btBg;
    
    IBOutlet UILabel *contentLab;
    
    CircleProgressView *circleProgressView;
    
    NSTimeInterval remainingTime;
    
}
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) Session *session;

@property (nonatomic,copy)void(^chooseHeaderBtAction)(NSInteger index);

-(void)stopTimer;
@end

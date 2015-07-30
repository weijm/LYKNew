//
//  HireOfView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/30.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HireOfView : UIView
{
    //第一行的背景视图
    
    IBOutlet UIView *topBg;
    //第二行背景视图
    IBOutlet UIView *bottomBg;
    IBOutlet NSLayoutConstraint *cornerImgWidth;
    
    IBOutlet NSLayoutConstraint *cornerImgHeight;
   
    IBOutlet UILabel *hire;
    
}
@property (nonatomic,copy) void(^clickedHire)(int index);
-(void)loadItem:(NSArray*)array;
@end

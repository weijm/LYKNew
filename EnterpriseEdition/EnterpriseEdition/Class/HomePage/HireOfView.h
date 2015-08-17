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
    
    __weak IBOutlet UIView *topBg;
    
    //第二行背景视图
    
    __weak IBOutlet UIView *bottomBg;
    
    
    __weak IBOutlet NSLayoutConstraint *cornerImgWidth;
    
    __weak IBOutlet NSLayoutConstraint *cornerImgHeight;
   
    __weak IBOutlet UILabel *hire;
    
    
}
@property (nonatomic,copy) void(^clickedHire)(int index);
@property (nonatomic) BOOL isValid;
-(void)loadItem:(NSArray*)array;
@end

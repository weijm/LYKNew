//
//  TopImgBotTitleView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImgBotTitleView : UIView
{
    __weak IBOutlet NSLayoutConstraint *titleWidth;
    
    __weak IBOutlet UILabel *countLab;
    __weak IBOutlet UILabel *titLab;
    
}
-(void)loadData:(int)count;
@end

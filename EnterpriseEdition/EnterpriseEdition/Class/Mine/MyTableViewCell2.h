//
//  MyTableViewCell2.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell2 : UITableViewCell
{
    
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UIImageView *iconImg;
   
    __weak IBOutlet UILabel *phoneLab;
    __weak IBOutlet NSLayoutConstraint *lineToLeft;
    
    __weak IBOutlet NSLayoutConstraint *itemIconWdith;
    
    __weak IBOutlet NSLayoutConstraint *itemIconHeight;
    //箭头的宽高
    
    __weak IBOutlet NSLayoutConstraint *arrowWidth;
    __weak IBOutlet NSLayoutConstraint *arrowHeight;
}
-(void)loadSubView;
@end

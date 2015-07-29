//
//  MyTableViewCell0.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell0 : UITableViewCell
{
    //企业图标
    IBOutlet UIImageView *iconImg;
    //图标宽
    IBOutlet NSLayoutConstraint *iconWidth;
    //图标高
    IBOutlet NSLayoutConstraint *iconHeight;
    //位置标的宽
    
    IBOutlet NSLayoutConstraint *locationImgWidth;
    //位置标的高
    IBOutlet NSLayoutConstraint *locationImgHeight;
    //审核通过与未通过的宽与高
    
    IBOutlet NSLayoutConstraint *reviewWidth;
    
    IBOutlet NSLayoutConstraint *reviewHeight;
    //箭头的宽高
    
    IBOutlet NSLayoutConstraint *arrowwidth;
    
    IBOutlet NSLayoutConstraint *arrowHeight;
}
@end

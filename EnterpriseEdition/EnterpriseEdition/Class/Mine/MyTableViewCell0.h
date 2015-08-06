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
    __weak IBOutlet UIImageView *iconImg;
    //图标宽
    __weak IBOutlet NSLayoutConstraint *iconWidth;
    //图标高
    __weak IBOutlet NSLayoutConstraint *iconHeight;
    //位置标的宽
    
    IBOutlet NSLayoutConstraint *locationImgWidth;
    //位置标的高
    IBOutlet NSLayoutConstraint *locationImgHeight;
    //审核通过与未通过的宽与高
    
    __weak IBOutlet NSLayoutConstraint *reviewWidth;
    
    __weak IBOutlet NSLayoutConstraint *reviewHeight;
    //箭头的宽高
    
    __weak IBOutlet NSLayoutConstraint *arrowwidth;
    
    __weak IBOutlet NSLayoutConstraint *arrowHeight;
    __weak IBOutlet UILabel *locationLab;
    
    __weak IBOutlet UILabel *enterpriseNameLab;
    
}
@end

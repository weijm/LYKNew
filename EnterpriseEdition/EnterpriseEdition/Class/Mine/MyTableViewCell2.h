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
    
    IBOutlet UILabel *titleLab;
    IBOutlet UIImageView *iconImg;
   
    IBOutlet UILabel *phoneLab;
    IBOutlet NSLayoutConstraint *lineToLeft;
}
-(void)loadSubView;
@end

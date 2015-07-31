//
//  TitleView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView
{
    
    IBOutlet UIView *cornerView;
    
    IBOutlet NSLayoutConstraint *tLineWidth;
    
    IBOutlet NSLayoutConstraint *bLineWidth;
    IBOutlet UIView *tLine;
    
    IBOutlet UIView *bLine;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

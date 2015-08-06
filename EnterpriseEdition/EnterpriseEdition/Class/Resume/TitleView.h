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
    
    __weak IBOutlet UIView *cornerView;
    
    __weak IBOutlet NSLayoutConstraint *tLineWidth;
    
    __weak IBOutlet NSLayoutConstraint *bLineWidth;
    __weak IBOutlet UIView *tLine;
    
    __weak IBOutlet UIView *bLine;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

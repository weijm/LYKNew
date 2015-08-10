//
//  ItemView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemView : UIView
{
    
    __weak IBOutlet NSLayoutConstraint *labHeight;
    
    __weak IBOutlet NSLayoutConstraint *iconWidth;
    
    __weak IBOutlet NSLayoutConstraint *iconHeight;
    
    __weak IBOutlet NSLayoutConstraint *iconY;
}
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
-(void)loadData:(NSDictionary*)dic;
@end

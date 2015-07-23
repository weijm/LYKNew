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
    
    IBOutlet NSLayoutConstraint *labHeight;
}
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
-(void)loadData;
@end

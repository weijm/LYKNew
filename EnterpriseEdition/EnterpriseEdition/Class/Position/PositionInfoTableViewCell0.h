//
//  PositionInfoTableViewCell0.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionInfoTableViewCell0 : UITableViewCell
{
    
    __weak IBOutlet NSLayoutConstraint *positionImgWidth;
    
    __weak IBOutlet NSLayoutConstraint *positionImgHeight;
    
    __weak IBOutlet UILabel *promptLab;
    
    
    __weak IBOutlet UILabel *titleLab;
    
    __weak IBOutlet UILabel *contentLab;
    __weak IBOutlet UIImageView *statusImg;
    
    __weak IBOutlet UIImageView *urgentImg;
}
@property(nonatomic) BOOL isUrgentPosition;
-(void)loadData:(NSDictionary*)dictionary;
@end

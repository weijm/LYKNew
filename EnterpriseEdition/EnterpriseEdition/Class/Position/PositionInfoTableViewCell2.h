//
//  PositionInfoTableViewCell2.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionInfoTableViewCell2 : UITableViewCell
{
    __weak IBOutlet NSLayoutConstraint *iconWidth;
    
    __weak IBOutlet NSLayoutConstraint *iconHeight;
    
    __weak IBOutlet UITextView *textView;

}
-(void)loadData:(NSString*)content;
@end

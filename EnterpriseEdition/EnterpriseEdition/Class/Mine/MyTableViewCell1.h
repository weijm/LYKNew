//
//  MyTableViewCell1.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell1 : UITableViewCell
{
    
    __weak IBOutlet UIView *bg;

}
-(void)loadsubView:(NSDictionary*)dictionary;
@end

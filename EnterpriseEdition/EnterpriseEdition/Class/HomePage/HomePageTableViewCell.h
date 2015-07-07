//
//  HomePageTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageTableViewCell : UITableViewCell
{
    
    IBOutlet UIView *addBg;
    IBOutlet UIView *contentBg;
    //标题
    IBOutlet UILabel *titleLab;
    //标题前面的icon
    IBOutlet UIImageView *iconImag;
}
-(void)loadEveryCell;
@end

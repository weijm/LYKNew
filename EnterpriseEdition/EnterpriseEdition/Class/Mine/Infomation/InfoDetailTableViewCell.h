//
//  InfoDetailTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailTableViewCell : UITableViewCell
{
    UIView *bg;

    
    UITextView *contentTextView;

}
@property(nonatomic) int infoType;
/**
 加载数据 及视图
 */
-(void)loadsubView:(NSDictionary*)dictionary;
@end

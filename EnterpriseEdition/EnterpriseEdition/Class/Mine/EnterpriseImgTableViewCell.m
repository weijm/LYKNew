//
//  EnterpriseImgTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "EnterpriseImgTableViewCell.h"

@implementation EnterpriseImgTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (kIphone6plus) {
        xingHeight.constant = xingHeight.constant+1;
        xingWidth.constant = xingWidth.constant+1;
        
        addImgHeight.constant = addImgHeight.constant+6;
        addImgWidth.constant = addImgWidth.constant+6;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initData:(NSDictionary*)dictionary
{
    titleLab.text = [dictionary objectForKey:@"title"];
    if (self.tag == 8) {
        requiredMarkImg.hidden = YES;
    }else
    {
        requiredMarkImg.hidden = NO;

    }
}

- (IBAction)addPictureAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(addPicture:)]) {
        [_delegate addPicture:(int)self.tag];
    }
}
@end

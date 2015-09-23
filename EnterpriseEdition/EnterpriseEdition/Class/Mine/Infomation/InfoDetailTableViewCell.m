//
//  InfoDetailTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "InfoDetailTableViewCell.h"

@implementation InfoDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载数据 及视图
-(void)loadsubView:(NSDictionary*)dictionary
{
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    if (dictionary!=nil) {
        
        NSString *content = [Util getCorrectString:[dictionary objectForKey:@"content"]];
        float viewW = kWidth - [Util myXOrWidth:5]*2;
        
         CGSize theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
        
        float bgH = theStringSize.height+[Util myYOrHeight:40];
        if (kIphone4||kIphone5) {
            bgH = theStringSize.height+65;
        }
        bg = [[UIView alloc] initWithFrame:CGRectMake([Util myXOrWidth:5], [Util myYOrHeight:5], viewW, bgH)];
        bg.backgroundColor = [UIColor whiteColor];
        bg.layer.cornerRadius = 5.0;
        bg.layer.masksToBounds = YES;
        [self.contentView addSubview:bg];
        
        contentTextView = [[UITextView alloc] initWithFrame:bg.frame];
        contentTextView.text = content;
        contentTextView.userInteractionEnabled = NO;
        contentTextView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:contentTextView];
        [self setTextViewParagraphStyle];
    }
}
-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
-(void)setTextViewParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(115, 115, 115, 1.0)
                                 };
    contentTextView.attributedText = [[NSAttributedString alloc] initWithString:contentTextView.text attributes:attributes];
}
@end

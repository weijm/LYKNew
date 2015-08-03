//
//  SignViewController.m
//  anxin
//
//  Created by 安心财富 on 14-1-9.
//  Copyright (c) 2014年 彭兴. All rights reserved.
//

#import "UIView+ViewController.h"


@implementation UIView (ViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
    
}

@end

//
//  UIScrollView+UItouch.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "UIScrollView+UItouch.h"

@implementation UIScrollView (UItouch)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
    //NSLog(@"MyScrollView touch Began");
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}


@end

//
//  Location.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "Location.h"

@implementation Location
+(Location *)shareLocation
{
    static Location *book=nil;
    @synchronized(self)
    {
        if (book==nil)
        {
            book=[Location new];
        }
    }
    return book;
}
@end

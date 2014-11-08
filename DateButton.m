//
//  DateButton.m
//  重写日历
//
//  Created by 刘 吕琴 on 14-6-23.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "DateButton.h"

@implementation DateButton
- (instancetype)init
{
    self = [super init];
    if (self) {
//        _titleRTLab = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 320/7+1, 45)];
//        //_titleRTLab.textAlignment = NSTextAlignmentCenter;
//        _titleRTLab.textColor = [UIColor grayColor];
//        _titleRTLab.backgroundColor = [UIColor clearColor];
//        _titleRTLab.userInteractionEnabled = YES;
//        [self addSubview:_titleRTLab];
        
    }
    return self;
}
-(NSDate*)getDate{
    return self.date;
}
-(NSString*)getRMB{
    return _RMB;
}
-(NSString*)getDollar{
    return _dollar;
}
@end

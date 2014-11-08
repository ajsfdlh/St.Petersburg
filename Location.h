//
//  Location.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
@property(nonatomic,strong)NSString *location;
+(Location *)shareLocation;
@end

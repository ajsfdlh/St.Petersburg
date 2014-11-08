//
//  NSData+MBBase64.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-12.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MBBase64)
+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
-(NSString *)base64Encoding;
@end

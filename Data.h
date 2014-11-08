//
//  Data.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"Reachability.h"
@interface Data : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic,strong)UIImage*image;
@property(nonatomic,strong)UIImage*headImage;
@property(nonatomic,strong)NSArray*dataArray;
@property (strong, nonatomic)Reachability*rea;
@property(nonatomic,strong)NSData*data;
+(Data*)shareNet;
//+(void)YiBuRequestandMethod:(NSString*)method andDomain:( NSMutableString*)domain andHttpMethod:(NSString*)POSTorGET  andArgument:(NSDictionary*)argument andDelegate:(id<NSURLConnectionDataDelegate>)delegate;
+(UIButton*)createNonet;
@end

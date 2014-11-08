//
//  Data.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "Data.h"

@implementation Data
+(Data *)shareNet
{
    static Data *net=nil;
    @synchronized(self)
    {
        if (net==nil)
        {
            net=[Data new];
        }
    }
    return net;
}
+(UIButton*)createNonet
{

   UIButton* noNetButton=[UIButton buttonWithType:UIButtonTypeCustom];
    noNetButton.frame=CGRectMake(0, 0, 320, 40);
    [noNetButton setImage:[UIImage imageNamed:@"noNet.gif"] forState:UIControlStateNormal];
    
   // [noNetButton addTarget:self action:@selector(noNet) forControlEvents:UIControlEventTouchUpInside];
    return noNetButton;
}

//GO_NET
@end

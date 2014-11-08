//
//  MineMemberViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-12.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMemberViewController : UIViewController<NSURLConnectionDataDelegate>
{
    UIView*memberCenter;
    UIImageView*name_image;
    UILabel*name_string;
    UILabel*name_style;
    NSMutableData*datas;
    NSDictionary*dic3;
    NSMutableArray*array;

    
    
}
@property(nonatomic,assign)int useID;
@property(nonatomic,strong)NSString*useName;


@end

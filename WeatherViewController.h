//
//  WeatherViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-24.
//  Copyright (c) 2014年 ;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<NSURLConnectionDataDelegate>
{

    NSMutableData*datas;
    NSDictionary * weatherDic;
    UIView*view;
    UIActivityIndicatorView *ActivityIndicator;
   // UIImageView*refresh;
    UIButton*noNetButton;
    
    UIImageView *rotateIV;
}
@end

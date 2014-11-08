//
//  TimeAndMoneyViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-24.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberKeypadDecimalPoint.h"
#import"ClockView.h"
@interface TimeAndMoneyViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate>
{

    NSMutableString*str;
     NSMutableString*str1;
     NSMutableString*str2;
    NumberKeypadDecimalPoint*numberKeyPad;
    ClockView*clock1;
    ClockView*clock2;
     NSMutableData*datas;
    float USDRUB;
    float USDCNY;
    float USDEUR;
    UIScrollView*Money;
}
@property(strong,nonatomic)NSString*pageName;
@end

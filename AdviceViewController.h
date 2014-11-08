//
//  AdviceViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate>
{
 NSMutableData*datas;
    UITextField*textField2;
    UITextView*textView;
    UIScrollView*scrollView;
}


@end

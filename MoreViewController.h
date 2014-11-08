//
//  MoreViewController.h
//  Sochi
//
//  Created by 刘 吕琴 on 14-1-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<NSURLConnectionDataDelegate>{
    NSMutableData *datas;
    UIScrollView*scroll;
    UIView*view2;
    UIView*view3;
    NSMutableArray *_dataArr;;
}

@end

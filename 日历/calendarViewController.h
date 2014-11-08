//
//  calendarViewController.h
//  rili
//
//  Created by beginner on 14-10-13.
//  Copyright (c) 2014年 beginner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calenderView.h"
@class calenderView;
@interface calendarViewController : UIViewController<NSURLConnectionDataDelegate>


@property (nonatomic , retain) calenderView *aaC;
@property (nonatomic , retain) UIView *underView;
@property (nonatomic , retain) UIScrollView *ScrollV;

- (void)tappedDate:(UIButton *)sender;


@end

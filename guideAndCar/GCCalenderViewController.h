//
//  GCCalenderViewController.h
//  St.Petersburg
//
//  Created by beginner on 14-11-5.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calenderView.h"
#import "CarAndGuideReseverViewController.h"


@class calenderView;
@class CarAndGuideReseverViewController;
@interface GCCalenderViewController : UIViewController<NSURLConnectionDataDelegate>
@property (nonatomic , retain) UIView *underView;
@property (nonatomic , retain) calenderView *calenderV;
@property (nonatomic , retain) UIScrollView *ScrollV;
@property (nonatomic , retain) NSString *ID;
@property (nonatomic , retain) NSString *guideType;
@property (nonatomic , weak) CarAndGuideReseverViewController *CGRV;

- (void)tappedDate:(UIButton *)sender;

@end

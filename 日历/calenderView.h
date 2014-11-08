//
//  calenderView.h
//  rili
//
//  Created by beginner on 14-10-13.
//  Copyright (c) 2014年 beginner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calendarViewController.h"
#import "hotelCarenderViewController.h"
#import "GCCalenderViewController.h"

@class calendarViewController;
@class hotelCarenderViewController;
@class GCCalenderViewController;
@interface calenderView : UIView


@property (nonatomic , strong) NSDate *calendarDate;
@property (nonatomic , weak) calendarViewController *CVC;
@property (nonatomic , weak) hotelCarenderViewController *HCVC;
@property (nonatomic , weak) GCCalenderViewController *GCCVC;
@property (nonatomic , assign) NSInteger year;
@property (nonatomic , assign) NSInteger month;
@property (nonatomic , assign) NSInteger day;


- (void)GetData;

@end

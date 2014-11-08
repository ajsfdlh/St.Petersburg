//
//  hotelCarenderViewController.h
//  St.Petersburg
//
//  Created by beginner on 14-10-20.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calenderView.h"
#import "LineReseverClass.h"
#import "EntainReseverClass.h"

@class calenderView;
typedef  void(^MyBlock)(NSString *str);
@interface hotelCarenderViewController : UIViewController

@property (nonatomic , retain) calenderView *calenderV;
@property (nonatomic , retain) UIScrollView *ScrollV;
@property (nonatomic , retain) NSString *ID;
@property (nonatomic , retain) NSString *checkDate;
@property (nonatomic , retain) NSDictionary *dataDic;
@property (nonatomic , assign) NSInteger lastDay;
@property (nonatomic , weak) NSString *prodType;
@property (nonatomic , retain) NSString *HotelRUName;
@property (nonatomic , retain) NSString *HotelCNName;
@property (nonatomic , retain) NSString *showTime;
@property (nonatomic , strong) MyBlock block;
@property (nonatomic , weak) LineReseverClass *lineRC;
@property (nonatomic , weak) EntainReseverClass *entainRC;
@property (nonatomic , retain) NSMutableArray *CIOArr;
@property (nonatomic ) BOOL hotelBool;
@property (nonatomic , assign) NSInteger endD;
@property (nonatomic , assign) NSInteger BtnD;




- (void)tappedDate:(UIButton *)sender;



@end

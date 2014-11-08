//
//  CACalenderViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCalenderViewController : UIViewController<NSURLConnectionDataDelegate>{
    UILabel *headDateLab;
    NSMutableArray *dayArrs;
    NSDate *currutDate;
    float cellWide;
    NSRange monthRange;
    int     currentDayIndexOfMonth;
    int     firstDayIndexOfWeek;
    
    
    //网络数据
    NSMutableData *datas;
    NSMutableArray *dataArrs;
    //总价
    RTLabel *price;
    
    UIButton*orderButton;
    NSDateFormatter *formatter;
    NSDateFormatter *startDate2Formatter;
    
//    NSString *hms;
//    NSArray *hmsArr;
//    NSDate *startDateHMS;
    
    NSDate *today;
    
    UIScrollView *sv;
}
@property (nonatomic , retain)NSCalendar *calendar;
@property (nonatomic , retain)NSString *ProdType;
//@property (nonatomic , retain)NSString *canOrderDateStr;
//@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , copy)NSString *ID;
//@property (nonatomic,   copy)NSString *isLookStr;
@property (nonatomic , copy) NSString *dayCount;
@property (nonatomic ,copy)NSString *dollar;
@property (nonatomic ,copy)NSString *RMB;
//@property (nonatomic ,copy)NSString *startDate;
@property (nonatomic ,copy)NSString *startDate2Str;//当前系统时间
//@property (nonatomic ,copy)NSString *ToDateStr;//提前预约时间
//@property (nonatomic ,copy)NSString *endDate;
//@property (nonatomic ,copy)NSString *isInOrOut;
//@property (nonatomic , retain)NSDate *checkDate;
//@property (nonatomic , retain)NSDate *check_outDate;
//@property (nonatomic , retain)NSDate *startDateMinDate;//预约最小日期
//查看
//@property (nonatomic , retain)NSString *hms;
//@property (nonatomic,retain)NSDictionary *dataDic;
//@property (nonatomic,retain)NSDictionary *dataDicHead;
@property (nonatomic,retain)NSMutableArray *selectDays;
@property (nonatomic,retain)NSMutableArray *addDays;
@property (nonatomic,retain)NSMutableArray *removerDays;
@end

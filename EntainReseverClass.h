//
//  EntainReseverClass.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntainReseverClass : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate>{
    UIScrollView *sv;
    NSMutableArray *dataArr;
    NSMutableString *dataStr;
    //头
    UILabel *russianName;
    UILabel *chineseName;
    UITextField *zhong;
    UIButton *jian;
    UIButton *jia;
    
  
    //roomUser
    // NSMutableString *roomInformationStr;
    //
    float viewHeight;
    float footerViewHeight;
    //总控制图
    UIView *footerView;
    //用户资料
    //  UIView *userDataView;
    NSMutableString *userConnectInformationStr;
    //支付
    NSMutableArray *pointIVArr;
    
    //总价
    RTLabel *price;
    NSString *paytype;
    
    
    NSMutableData *datas;
}
@property (nonatomic , copy)NSString *ProdType;
@property (nonatomic , copy)NSString *ID;
@property (nonatomic , copy)NSString *russianStr;
@property (nonatomic , copy)NSString *chineseStr;
@property (nonatomic , copy)NSString *roomTypeStr;
@property (nonatomic , copy)NSString *peopleMaxCountStr;
@property (nonatomic , copy)NSString *roomFacilityStr;
@property (nonatomic , copy)NSString *payWay;//1 在线 2 当面和在线
@property (nonatomic , copy)NSString *reseverKnowStr;//预订须知
@property (nonatomic ,copy)NSString *dollar;
@property (nonatomic ,copy)NSString *RMB;
@property (nonatomic ,copy)NSString *showTime;
@property (nonatomic ,copy)NSString *startDate;
@property (nonatomic ,copy)NSString *endDate;
@property (nonatomic ,retain)NSDateFormatter *formatter;
@property (nonatomic ,retain)NSDateComponents *components;
@property (nonatomic , retain)NSString *checkDate;
@property (nonatomic , retain)NSString *check_outDate;
@property (nonatomic ,copy)NSString *startDate2Str;//当前系统时间
@property (nonatomic ,copy)NSString *ToDateStr;//提前预约时间
@property (nonatomic , retain)NSDate *startDateMinDate;//预约最小日期
@property (nonatomic , retain) NSDictionary *dataDic;
@property (nonatomic , assign) NSInteger ticketCount;

@end

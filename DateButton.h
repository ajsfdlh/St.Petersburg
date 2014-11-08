//
//  DateButton.h
//  重写日历
//
//  Created by 刘 吕琴 on 14-6-23.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface DateButton : UIButton
@property(nonatomic , retain)NSDate *date;
@property(nonatomic , copy)NSString *RMB;
@property (nonatomic ,copy)NSString *dollar;
@property(nonatomic , copy)NSString *surplusCount;
@property (nonatomic , copy)NSAttributedString *attributedTittleStr;
//@property(nonatomic , retain)RTLabel*titleRTLab;
-(NSDate*)getDate;
-(NSString*)getRMB;
-(NSString*)getDollar;
@end

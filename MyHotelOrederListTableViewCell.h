//
//  MyHotelOrederListTableViewCell.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface MyHotelOrederListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *payWayLab;
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UILabel *russualTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *chineseTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *subheadLab;
@property (strong, nonatomic) IBOutlet UILabel *checkInLab;
@property (strong, nonatomic) IBOutlet UILabel *statusLab;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;//日期
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLab;//订单状态
@property (strong, nonatomic) IBOutlet UIImageView *moreIV;// >
@property (strong, nonatomic) IBOutlet UIImageView *downIV;

@end

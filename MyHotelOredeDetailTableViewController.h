//
//  MyHotelOredeDetailTableViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHotelOredeDetailTableViewController : UITableViewController
@property (strong , nonatomic)NSDictionary *currentDic;
@property (strong ,nonatomic)NSAttributedString *priceStr;
@property (strong ,nonatomic)NSString *subheadStr;
@property (strong ,nonatomic)UIImage *headImage;
@property (strong ,nonatomic)NSString *payStr;
@property (strong ,nonatomic)NSMutableArray *tableArr;
//头
@property (assign, nonatomic) int hotelID;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *payWayLab;
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UILabel *russualTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *chineseTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *subheadLab;
@property (strong, nonatomic) IBOutlet UILabel *maxCheckInCountLab;
@property (strong, nonatomic) IBOutlet UILabel *roomFacilityLab;
@property (strong, nonatomic) IBOutlet UILabel *statusLab;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
@property (strong, nonatomic) IBOutlet UILabel *checkInDateLab;
@property (strong, nonatomic) IBOutlet UILabel *checkOutDateLab;
@property (strong, nonatomic) IBOutlet UILabel *roomCountLab;
//尾
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *nemeLab;
@property (strong, nonatomic) IBOutlet UILabel *telephoneNumLab;
@property (strong, nonatomic) IBOutlet UILabel *mailLab;
@property (strong, nonatomic) IBOutlet UILabel *QQLab;
@property (strong, nonatomic) IBOutlet UILabel *weixinLab;
@property (strong, nonatomic) IBOutlet UIView *footerBarView;
@property (strong, nonatomic) UIButton *goSecondButton;

@end

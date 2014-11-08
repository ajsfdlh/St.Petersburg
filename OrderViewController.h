//
//  OrderViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-6-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlixLibService.h"
#import "MyHotelOredeDetailTableViewController.h"

@interface OrderViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic , copy) NSString * payWay;//1在线支付   2在线和当面支付
@property (nonatomic , copy) NSString *selectPayWay;//1.微信支付  2、3.支付宝支付  4.银联支付  5.信用卡支付  6.当面支付
@property (nonatomic , copy) NSString *dollar;
@property (nonatomic , copy) NSString *RMB;
@property (nonatomic , copy) NSString *dayCount;
@property (nonatomic , copy) NSString *roomCount;
@property (nonatomic , copy) NSString *orderNumber;//用来传酒店ID或订单号
@property (nonatomic , copy) NSString *productName;
@property (nonatomic , copy) NSString *productDescription;
@property (nonatomic , assign) int prodClass;
@property (nonatomic , assign) int presentWay;//用来区分从哪个页面present进来的
@property (nonatomic , retain) UIScrollView* scrollView;
@property (nonatomic , retain) RTLabel* totalPrice;//显示价格的label
@property (nonatomic , strong) MyHotelOredeDetailTableViewController* mhodTVC;

+(OrderViewController*)sharedOrderViewController;
- (void)parse:(NSURL *)url application:(UIApplication *)application;
-(void)paymentResult:(NSString*)result;

@end

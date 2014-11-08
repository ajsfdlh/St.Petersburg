//
//  MyEntainOrderDetailTableViewController.h
//  St.Petersburg
//
//  Created by kirem-peter on 14-11-5.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEntainOrderDetailTableViewController : UITableViewController

@property (retain, nonatomic)NSDictionary* currentDic;
@property (strong, nonatomic)NSMutableArray *tableArr;//存放有多少游客信息的
@property (copy, nonatomic)NSString* prodClass;//prodclass：1线路、2景点、3酒店、4门票、5导游、6租车

//topView中各项的值
@property (copy, nonatomic)NSAttributedString* orderPrice;
@property (copy, nonatomic)NSString* payStr;//支付方式

@property (strong, nonatomic)UIImage* headImage;

@end

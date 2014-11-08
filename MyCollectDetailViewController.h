//
//  MyCollectDetailViewController.h
//  St.Petersburg
//
//  Created by li on 14-5-13.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectDetailViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIView *bv;
    NSMutableData *datas;
    //int a;
    
    UITableView *myTableView;
    NSMutableArray *dataArr;
    
    UIActivityIndicatorView*navActivity;
    //租车
    NSArray *tittles;
    NSArray *priceKey;
    
    NSString*picPath;
   // NSString*picName;
    NSString*picID;
}
@property (nonatomic ,retain)NSDictionary *detailDic;
@property (nonatomic ,copy)NSString *typeID;
@property (nonatomic)int count;
@end

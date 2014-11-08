//
//  MyTravelingViewController.h
//  St.Petersburg
//
//  Created by li on 14-5-9.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTravelingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    UIView *bv;
    
    UIRefreshControl *refresh;
    UIActivityIndicatorView *aiv;
   // UIView *centerView;
    UIView *foolerView;
    UIActivityIndicatorView *foolerAiv;
    UILabel *foolerLab;
    int footerTag;
    //cell
    NSArray *tittleArr;
    NSArray *imageNameArr;
    //数据
    NSMutableData *datas;
    

    UIButton *noNetButton;
}
@property (nonatomic ,retain)UITableView *myTableView;
@property (nonatomic , retain)NSMutableArray *dataArr;
@end

//
//  MyCollectViewController.h
//  St.Petersburg
//
//  Created by li on 14-5-13.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    UITableView *myTableView;
    NSArray*images;
    NSArray*titles;
    
    NSMutableArray *dataArr;
    NSArray *numberArr;
    NSMutableData *datas;
    
    UIButton *noNetButton;
}

@end

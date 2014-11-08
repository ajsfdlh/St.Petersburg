//
//  EveryDayViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EveryDayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
{

    UITableView*_tabView;
    NSMutableArray*dataArray;
      NSMutableData*datas;
   // NSMutableArray*picArray;
    UIActivityIndicatorView* navActivity;

}
@property(assign,nonatomic)int ID;
@property(assign,nonatomic)int Lineday;
@end

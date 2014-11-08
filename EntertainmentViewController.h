//
//  EntertainmentViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntertainmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
{

    UITableView*_tabView;
    NSArray*head;
    NSMutableData*datas;
   NSMutableArray*dataArray;
    NSString *urlMethod;
      UIRefreshControl*refresh;
}
@end

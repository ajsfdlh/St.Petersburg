//
//  NewsViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-19.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    NSString*weidu;
    UILabel*backbuttonlable;

    NSMutableArray*dataArray;

}
@end

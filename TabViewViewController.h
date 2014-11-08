//
//  TabViewViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate,UISearchDisplayDelegate>
{
    NSMutableData*datas;
    NSMutableArray*dataArray;
    NSMutableArray*topArray;
    UITableView*_tabView;
    UIScrollView*_scrollView;
       UIPageControl*pageControl;
    UIView*tabview;
       BOOL _loadingMore;
     NSInteger index;
    BOOL top;
    BOOL noTop;
    int topNum;
    
    UIRefreshControl*refresh;
    
    UIAlertView*remindAlert;
    UIActivityIndicatorView*act;
    
    UISearchBar*searchBar;
    UISearchDisplayController*searchDisplayC;
    BOOL isDisplay;
    NSMutableArray*dataForSearchArray;
    NSMutableArray*picArray;
    NSMutableArray*searchPicArray;
    NSString*picPath;
    NSString*picName;
    UIActivityIndicatorView* navActivity;
    UIButton*noNetButton;
}
@property(nonatomic,assign)int collectID;
@property(nonatomic,assign)int count;
@property(nonatomic,strong)NSString*tag;
@property(nonatomic,strong)NSString*pageName;
@end

//
//  TravelViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-18.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UITextViewDelegate,UIAlertViewDelegate,UIWebViewDelegate>
{
    UITableView*_tableView;
    NSMutableData*datas;
    NSArray*array;
    BOOL _loadingMore;
    int index1;
    UIView *tableFooterView;
    UITextView*_texteView;
    float height2;
    BOOL isLike;
    BOOL isComent;
    BOOL isCollect;
    BOOL isComentDone;
    NSDictionary*dic1;
    UIView*_scrollView;
    
    UIToolbar*toolBar;
    
    RTLabel*head;
    UILabel*Name;
    RTLabel*time;
    RTLabel*Msgcount1;
    RTLabel*Viewcount1;
    RTLabel*body;
    UIImageView*line;
    
    BOOL checkLike;
    
    NSString* checkCollectNum;
    BOOL checkCollect;
    NSString* checkLikeNum;
    
      UIWebView*_webView;
    UIButton*noNetButton;
    UIActivityIndicatorView* navActivity;
    UIRefreshControl*refresh;

}
@property(assign,nonatomic)int collectID;
@property(assign,nonatomic)int ID;
@property(strong,nonatomic)UIImage*userImage;
@end

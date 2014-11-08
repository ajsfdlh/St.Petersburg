//
//  InfomDetailViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-17.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfomDetailViewController : UIViewController<NSURLConnectionDataDelegate,UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView*_webView;
     NSMutableData*datas;
    NSMutableArray*dataArray;
    UIScrollView*_scrollView;
    RTLabel*time;
     UIActivityIndicatorView* navActivity;
     UIButton*noNetButton;
    
    UIRefreshControl *refresh;
}
@property(assign,nonatomic)int ID;
@property(strong,nonatomic)NSString*pageName;
@end

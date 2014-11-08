//
//  EntainDetailViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-25.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntainDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>{//CalenderViewControllerDelegate,
    UITableView*_tableView;
     UIPageControl*pageControl;
    UIScrollView*_scrollView;
    UIView*tabHead;
    int pre ;
    int boom;
    
    NSMutableData*datas;
    NSMutableArray*dataArray;
    NSDictionary*dataDic;
    CGSize s;
    RTLabel*introduceLable;
    BOOL checkCollect;
    BOOL  checkLike;
    
    NSString* checkLikeNum;
    NSString* checkCollectNum;

    BOOL isLike;
    BOOL isCollect;
    
    UIAlertView*remindAlert;
    UIActivityIndicatorView*act;
    UILabel*pic_imageLable;
    
    NSMutableArray*picUrlArray;
    NSMutableArray*picArray;
    float imgeHeight;
    BOOL isTime;
    UIScrollView*picScrollView;
    
    NSString*dicPath;
    NSString*arrayPath;
    NSString*dicMethod;
    NSString*arrayMethod;
    NSMutableString*urlDomain;
    NSString*picMethod;
    NSString*picPath;
    
    
    NSMutableArray*commentArray;
    NSMutableArray*commentArray2;
    NSMutableArray*commentPic;
    int moreComment;
    
    NSArray*title2;
    int f;
    NSArray*arr;
    
    UIRefreshControl*refresh;
    
    
    BOOL isGetPic;
    BOOL isGetProduct;
    BOOL isGetComment;

    UIImageView*userImage;
    UIButton*noNetButton;
    UIActivityIndicatorView* navActivity;
    
    NSIndexPath *indexPath2;
    
    NSOperationQueue *queue;
   // NSString*date;
    RTLabel *validityLable2;
    
}
@property(nonatomic,strong)NSString*picPath2;
@property(nonatomic,strong)NSString*navName;
@property(nonatomic,strong)UIImage* fromeImage;
@property(nonatomic,assign)int hotelID;
@property(nonatomic,assign)int classID;
@property(nonatomic,assign)int tag;
@property(nonatomic,assign)int TicketType;
@property(nonatomic,assign)NSDictionary*dataDic2;

@end

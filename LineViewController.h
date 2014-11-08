//
//  LineViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-25.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"
#import"Data.h"
@interface LineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UISearchDisplayDelegate>
{   //CalenderViewControllerDelegate,
    UITableView*_tabView;
    UIView*view;
     NSMutableData*datas;
    NSMutableArray*AllTitle;
     NSMutableArray*lineArray;
    NSArray*defaultTitle;
      NMRangeSlider*slider;
    UIImageView*LineView;
  
    UIImageView*triangle;
    UIImageView*defaultArrange;
      UIImageView*allType;
    
    NSMutableDictionary*lineTypeDic;
    
    
    NSMutableString*linetypeStr;
    NSMutableArray*linetypeArray;
    NSMutableArray*oldLinetypeArray;
    int linedays;
    int oldLineDays;
    
    int lowprice;
    int oldLowprice;
    int higprice;
    int oldHigprice;    
    
    int orderbystr;
    
    int tag;      

    
    BOOL isSelect;
     NSMutableArray*arrayType;
    UIRefreshControl*refresh;
     UIView*filterView;
    UIView*SelectData;
    UIView*SelectPrice;
     UIScrollView*SelectType;
    UIScrollView*SelectDay;
    NSArray*array;
    
    int sendTag;
    
    NSDictionary*stockForKVO;
    
    UISearchBar* searchBar;
    UISearchDisplayController*searchDisplayC;
    BOOL isDisplay;
    NSMutableArray* dataForSearchArray;

    UIAlertView*remindAlert;
    UIActivityIndicatorView*act;
    BOOL _loadingMore;
    int index1;
    int isSave;
    
    NSString*str11;
    
//    NSMutableArray*picArray;
//    NSMutableArray*searchPicArray;
    UIButton*noNetButton;
    
    UIActivityIndicatorView* navActivity;

}
@property(nonatomic,assign)int collectID;
@property(nonatomic,assign)int count;
@property(nonatomic,strong)NSDate*FromDate;
@property(nonatomic,strong)NSDate*ToDate;
-(void)endRefresh:(UIRefreshControl*)_refresh;
-(NSString *)filePath:(NSString*)text;
- (void)loadPic_tableViewDataArray:(NSMutableArray*)mainDataArr objectAtIndex:(int)indexTag objectForKey:(NSString*)dicKey picHeadUrlStr:(NSMutableString*)picUrl picUrlPathStr:(NSString*)picPathStr PicLoadName:(NSString*)name headView:(UIImageView *)headView;

@end

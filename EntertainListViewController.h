//
//  EntertainListViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntertainListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UISearchDisplayDelegate>

{
    UITableView*_tabView;
    UIView*filterView;
    UIScrollView*SelectType;
    UIScrollView*SelectPlace;

    UIView*SelectData;
    UIView*SelectPrice;
      NMRangeSlider*slider;
     NSArray*array;
     NSMutableData*datas;
    NSMutableArray*dataArray;
   

    
    UIScrollView*_scrollView;
    UIPageControl*pageControl;

    UISearchBar* searchBar;
    UISearchDisplayController*searchDisplayC;
    BOOL isDisplay;
    
    NSMutableArray* dataForSearchArray;
    int orderbystr;
    int oldLowprice;
    int oldHigprice;
    int oldLineDays;
    int linedays;
    int lowprice;
    int higprice;
    NSString*startData;
    NSString*oldStartData;
    
    NSString*endData;
    NSString*oldEndData;

    
    NSMutableString*star;
    NSMutableArray*starArray;
     NSMutableArray*oldStarArray;
    
    NSMutableString*arear;
    NSMutableArray*arearArray;
    NSMutableArray*oldArearArray;
    
    int sendTag;
    NSString*linetypeStr;
    NSMutableArray*oldLinetypeArray;
    NSMutableArray*linetypeArray;
    NSMutableArray*headerArray;
    NSMutableArray*arrayType;
      NSArray*_arrayType;
    
    CGSize lableHeight;
    
    UIAlertView*remindAlert;
    UIActivityIndicatorView*act;
    UIRefreshControl*refresh;
    int index1;
    BOOL _loadingMore;
    BOOL isFilter;
    
    NSString*hotelListName;
    NSString*adervtProdPics;
    
  
    NSString*dataMethod;
    
    int isSave;
    UIScrollView*SelectSex;
    int oldSex;
    int Sex;
    UIScrollView*SelectCountry;
    int oldCountry;
    int Country;
    UIScrollView*SelectSkilled;
    NSArray*_arrayType2;
    NSMutableString*SkilledStr;
    NSMutableArray*oldSkilledArray;
    NSMutableArray*SkilledArray;
    
    UIScrollView*SelectTranslateSkilled;
    NSMutableString*TranslateStr;
    NSMutableArray*oldTranslateArray;
    NSMutableArray*TranslateArray;
    NSArray*_arrayType3;
    
//    
//    NSMutableArray*picArray;
    NSString*picPath;
    NSString*picName;
    NSString*picID;
//    NSMutableArray*searchPicArray;
    
    NSMutableArray *guideAndTransitionArr;
    
    UIButton*noNetButton;
    UIActivityIndicatorView*navActivity;
  

    
    NSArray *tittles;
    NSArray *priceKey;
}
@property(nonatomic,strong)NSDate*FromDate;
@property(nonatomic,strong)NSDate*ToDate;
@property(nonatomic,strong)NSString*navName;
@property(nonatomic,assign)int ticketclass;
@property(nonatomic,strong)NSString*introduce;
@property(nonatomic,strong)NSString*headerStr;
@property(nonatomic,assign)int tag;
@property(nonatomic,assign)int typeId;
@property(nonatomic,assign)int collectId;
@property(nonatomic,assign)int count;
-(void)creatSelectPrice;
-(void)clearAll:(int)tag andCount:(int)count;

@end

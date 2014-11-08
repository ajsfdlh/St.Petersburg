//
//  GuideDetailViewController.h
//  St.Petersburg
//
//  Created by li on 14-4-29.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideDetailViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *myTableView;
    NSMutableArray *tableArr;
    NSDictionary *dic2;
    NSArray *picArr;
    NSArray *titleArr;
    NSMutableArray *textArr;
    
    
    BOOL isLike;
    BOOL isCollect;
    BOOL checkLike;
    
    BOOL checkCollect;
  //  UIImage *picImage;
    NSString* checkLikeNum;
    NSString* checkCollectNum;
    NSOperationQueue *queue;
    UIView *headView;
    RTLabel *footLab;
    
    UIAlertView*remindAlert;
    UIActivityIndicatorView*act;

}

@property (nonatomic , copy)NSString *gudieID;
@property (nonatomic , retain)NSMutableData *datas;
@property (nonatomic ,retain)UIImageView *iv;
@property (nonatomic ,retain)RTLabel *nameLab;
@property (nonatomic ,retain)RTLabel *sexLab;
@property (nonatomic ,retain)RTLabel *typeLab;
@property (nonatomic ,retain)RTLabel *countryLab;
//@property (nonatomic ,retain)RTLabel *positionLab;
@property (nonatomic ,retain)RTLabel *dayLab;
@property (nonatomic ,retain)UIImage *picImage;

@property (nonatomic)int tag;//2导游3租车



@end

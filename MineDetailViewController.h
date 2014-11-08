//
//  MineDetailViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SEVERICE_IMAGE @"serviceHeardImage"
@interface MineDetailViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDataDelegate>
{
//   UIView*memberCenter;
    UIImageView*name_image;
    NSArray*array;
    UIScrollView*scrollView;
    NSArray* file;
    NSMutableArray*provinces;
    NSArray* country;
    NSArray* city;
    NSArray*allArray;
    NSMutableData*datas;
    NSDictionary*dic3;
    NSMutableArray*dataArray;
    UILabel*name_string;
    UILabel*name_style;
    
}
@property (strong,nonatomic)NSDictionary *severiceDic;
@property (strong,nonatomic)UIImage *severiceImage;
@property(strong,nonatomic)NSString*local1;
@property(strong,nonatomic)NSString*local2;
@property(strong,nonatomic)NSString*local3;
@property(assign,nonatomic)int useID;
@property(strong,nonatomic)NSString*pageTitle;
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSMutableArray*textArray;
@property(nonatomic, assign) NSTimeInterval touchTimer;
@property(nonatomic,strong)NSString*name_style2;


@end

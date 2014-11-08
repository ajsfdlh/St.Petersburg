//
//  MineViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MineViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
{
    NSMutableData*datas;
    UITextField*textFieldPasscode;
    UITextField*textFieldName;
    UIView*logView;
    UIScrollView *sv;
  
     UIView*memberCenter;
    UIView*memberCenter2;
    UIView*memberCenter3;//导游、租车
//    UIView*memberCenter;
    UIImageView*name_image;
    UILabel*name_string;
    NSMutableArray*array;
    int ID;
    NSMutableArray*dataArray;
    UILabel*num;
    UILabel*num2;
    UILabel*myNum;
//    UILabel*name_string;
    UILabel*name_style;
    BOOL isHave;
    BOOL isLogin;
    
    
    NSString *picPath;
    NSString *picName;

    
    UIButton *noNetButton;
}
@property(nonatomic,assign)int tag;
@property (nonatomic , retain)UIButton*memberCenter_name;
- (void)loadPic_tableViewIndexPath:(NSIndexPath*)indexPath headLabName:(NSString*)name headView:(UIImageView *)headView;
@end

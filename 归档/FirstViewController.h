//
//  FirstViewController.h
//  通信界面
//
//  Created by li on 14-3-28.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate>{
    NSMutableData *datas;
    UIView *barView;
    CGRect mainScreenFrame;
    NSUserDefaults *defaults;
     int btnTag;
    
    UIButton*noNetButton;
    
    NSString *picPath;
    NSString *picName;
}
@property (nonatomic)float viewHeight;
@property (nonatomic)float viewOY;
@property (nonatomic)int length;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic , retain)NSMutableArray *sayCellHeights;
@property (nonatomic ,retain)RTLabel *countCellHeight;


//cityid=%@&userid=%@&typeid=%@",@"2",QuseID,@"0"
//@property (nonatomic ,copy)NSString *cityid;
@property (nonatomic)int toTag;//判断进去那个接口0、1
@property (nonatomic , retain)NSDictionary *editDic;
@property (nonatomic ,copy)NSString *userid;
@property (nonatomic ,copy)NSString *userName;
//@property (nonatomic ,copy)NSString *toUserid;
@property (nonatomic ,copy)NSString * type_id;
//@property (nonatomic ,copy)NSString *mid;
@end

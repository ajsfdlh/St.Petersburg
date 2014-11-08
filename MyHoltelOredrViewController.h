//
//  MyHoltelOredrViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHoltelOredrViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    NSMutableData *datas;
    NSMutableArray *tableArr;//订单数据
    NSMutableArray *tableArrBtnOne;//近一个月的订单数据
    NSMutableArray *tableArrBtnTwo;//一个月前的订单数据
    int pageIndexOne;
    int pageIndexTwo;
    
    NSString*picPath;
    NSString*picName;
    NSString*picID;
    
    NSArray *payNames;//支付方式
    //NSArray *statuNames;
    
    int typeId;
    UIActivityIndicatorView *aicv;
    UIActivityIndicatorView *aicv2;
    UIRefreshControl *refreshControl;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;

- (IBAction)btnSelect:(UIButton *)sender;

@end

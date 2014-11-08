//
//  MessageViewController.h
//  St.Petersburg
//
//  Created by li on 14-4-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberLabel.h"
@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIButton *btn;
    UIButton *btn2;
    UITableView *_tableView;
    NSOperationQueue *queue;
    NSArray *arr;
    NSTimer *timer;
    NSTimer *newsNumber;
    //NSTimer *numberTimer;
    NSUserDefaults *defaults;

    //NSString *numberStr;
    int  fromTag;
    
}
//@property (nonatomic ,retain)NSMutableData *datas;
@property (nonatomic ,retain)NumberLabel *btnLab;
@property (nonatomic ,retain)NSMutableArray *messages;
@property (nonatomic ,retain)NSMutableArray *oldMessages;
@property (nonatomic ,copy)NSString *userName;

@end

//
//  ComentViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
     UITableView*_tableView;
     NSMutableArray* array;
     NSMutableData*datas;
    NSInteger index1;
    UIView*tableFooterView;
    BOOL isComent;
    UITextView*_textField;
     UIRefreshControl*refresh;
    UILabel*messgeCount;
   // int count;
      NSMutableArray*picArray;
    //没有评论
    UIView *bv;
}
@property(nonatomic,strong)NSString*pageName;
@property(nonatomic,copy)NSString*head;
@property(nonatomic,assign)int ID;
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString*eTittle;
@end

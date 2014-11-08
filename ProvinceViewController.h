//
//  ProvinceViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray*province;
    NSMutableArray*provinces;

}
@property(strong,nonatomic)NSString*pageName;
@end

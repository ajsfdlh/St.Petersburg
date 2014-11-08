//
//  CityViewController.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSArray*city;
}
@property(nonatomic,strong)NSString*province;
@property(nonatomic,assign) NSInteger indexth;
@end

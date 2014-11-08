//
//  LineDetailCell.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineDetailCell : UITableViewCell
@property(assign,nonatomic)int day;
@property(strong,nonatomic)RTLabel*titleLable;
@property(strong,nonatomic)UIImageView*link;
@end

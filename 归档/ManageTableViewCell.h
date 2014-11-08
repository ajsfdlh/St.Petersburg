//
//  ManageTableViewCell.h
//  通信界面
//
//  Created by li on 14-3-26.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTLabel;
@interface ManageTableViewCell : UITableViewCell
//内容
@property (nonatomic , retain)RTLabel *sayLable;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *head;
//名字
@property (retain, nonatomic)  RTLabel *name;
//泡泡
@property (nonatomic , retain)UIImageView *backImage;
@end

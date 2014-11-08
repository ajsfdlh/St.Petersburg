//
//  GuideTableViewCell.h
//  St.Petersburg
//
//  Created by li on 14-4-28.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface GuideTableViewCell : UITableViewCell
@property (nonatomic ,retain)RTLabel *nameLab;
@property (nonatomic ,retain)RTLabel *carLab;
@property (nonatomic ,retain)RTLabel *languageLab;
@property (nonatomic ,retain)RTLabel *sayLab;
@property (nonatomic ,retain)RTLabel *serviceLab;
@property (nonatomic ,retain)RTLabel *dayLab;


@property (nonatomic ,retain)UIImageView *iv;
@property (nonatomic ,retain)UIImageView *link;








@end

//
//  CustomCell.h
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
  UIImageView*name_image;
}
@property(nonatomic,strong)UILabel*string;
@property(nonatomic,strong)NSMutableArray*textArray;
@end

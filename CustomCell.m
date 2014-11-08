//
//  CustomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-17.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self addSubview:self._imageView];
        self.lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 40)];
        [self._imageView addSubview:self.lable];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

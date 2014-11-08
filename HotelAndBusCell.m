//
//  HotelAndBusCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-6.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "HotelAndBusCell.h"

@implementation HotelAndBusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
        
        self.backgroundColor=GroupColor;

        self._imageView=[UIButton buttonWithType:UIButtonTypeCustom];
        self._imageView.frame=CGRectMake(10, 10, 29,29);
        
        [self addSubview:self._imageView];
        
        
        self.head=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 265, 30)];
        self.head.font=[UIFont boldSystemFontOfSize:17];
        [self addSubview:self.head];
        
        
        self.title=[[RTLabel alloc]initWithFrame:CGRectMake(45, 50, 265, 0)];
        self.title.textColor=[UIColor grayColor];
        self.title.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.title];
        
        
        
        self.link=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 2)];
        self.link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:self.link];
        
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

//
//  SceneryCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-6.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SceneryCell.h"

@implementation SceneryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
            self.backgroundColor=GroupColor;
//        self.backGround=[[UIImageView alloc]init];
//        self.backGround.image=[UIImage imageNamed:@"LineDetail_white.png"];
//        [self addSubview:self.backGround];
        
        
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 29, 29)];
        
        [self addSubview:self.headImage];
        
        
        self.head=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 180, 30)];
        self.head.font=[UIFont boldSystemFontOfSize:17];
        [self addSubview:self.head];
        
        
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(45, 45, 265, 200)];
        self._imageView.image = BACK_IMAGE;
        [self addSubview:self._imageView];
        
        
        self.title=[[RTLabel alloc]initWithFrame:CGRectMake(45, 250, 265, 0)];
        self.title.textColor=[UIColor grayColor];
        
        self.title.font=[UIFont systemFontOfSize:14];
        
        
        
        [self addSubview:self.title];
        self.link=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 2)];
        self.link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:self.link];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

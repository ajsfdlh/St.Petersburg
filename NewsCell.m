//
//  NewsCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-19.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       self._imgeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
       self._imgeView.image=[UIImage imageNamed:@"mine_news.png"];
        [self addSubview:self._imgeView];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 280, 20)];
        self.title.font=[UIFont boldSystemFontOfSize:16];
        [self._imgeView addSubview:self.title];
        
        self.content=[[UILabel alloc]initWithFrame:CGRectMake(5, 35,280, 40)];
        self.content.font=[UIFont systemFontOfSize:14];
        self.content.numberOfLines=2;
        [self._imgeView addSubview:self.content];

        self.time=[[UILabel alloc]initWithFrame:CGRectMake(200, 10,115, 20)];
          [self addSubview:self.time];
        self.time.textColor=[UIColor grayColor];
        self.time.font=[UIFont systemFontOfSize:12];
        
        self.weidu=[[UILabel alloc]initWithFrame:CGRectMake(270, 35,40, 40)];
        self.weidu.font=[UIFont systemFontOfSize:13];
        self.weidu.backgroundColor=[UIColor clearColor];
        self.weidu.textColor=[UIColor redColor];
        [self._imgeView addSubview:self.weidu];
        
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

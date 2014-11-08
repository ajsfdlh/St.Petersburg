//
//  CustomCell2.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-17.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CustomCell2.h"

@implementation CustomCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        float X=10;
       
        float Width=100;
        float height=75;
        float Y=(100-height)/2;
        self.backgroundColor=GroupColor;
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, Width, height)];
        self._imageView.image=BACK_IMAGE;
        [self addSubview:self._imageView];
        self.lableHead=[[UILabel alloc]initWithFrame:CGRectMake(X+Width+5, Y, 304-Width-15, 20)];
        self.lableHead.numberOfLines=1;
        self.lableHead.font=[UIFont boldSystemFontOfSize:14];
         self.lableDetail=[[UILabel alloc]initWithFrame:CGRectMake(X+Width+5, Y+30, 310-Width-15, 0)];
        self.lableDetail.font=[UIFont systemFontOfSize:12];
        self.lableDetail.numberOfLines=2;
        [self addSubview:self.lableDetail];
        [self addSubview:self.lableHead];
        
        self.data=[[UILabel alloc]initWithFrame:CGRectMake(X+Width+5, 70,  310-Width-15, 20)];
        self.data.textColor=[UIColor grayColor];
        self.data.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.data];
        
        
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 98, 320,2)];
        link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:link];
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

//
//  HotelRoomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-13.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "HotelRoomCell.h"

@implementation HotelRoomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
       self.backGround=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        [self addSubview: self.backGround];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
        self._imageView.image = BACK_IMAGE;
        [self.backGround addSubview:self._imageView];
        
        self.head=[[RTLabel alloc]initWithFrame:CGRectMake(115, 15, 140, 20)];
        //self.head.text=@"标准双床房";
        self.head.font=[UIFont boldSystemFontOfSize:18];
        [self.backGround addSubview:self.head];
        
        self.title=[[RTLabel alloc]initWithFrame:CGRectMake(115, 35, 140, 50)];
        self.title.textColor=[UIColor grayColor];
        //self.title.text=@"早晨 大床 wifi";
        self.title.font=[UIFont systemFontOfSize:13];
        [self.backGround addSubview:self.title];

        
        self.price=[[RTLabel alloc]initWithFrame:CGRectMake(230, 10, 80, 30)];
        self.price.text=@"¥<font size=20 color=orange>520</font>";
        self.price.textAlignment=RTTextAlignmentRight;
        [self.backGround addSubview:self.price];
        
        
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 98, 320, 2)];
        link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self.backGround addSubview:link];
        
        
               
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

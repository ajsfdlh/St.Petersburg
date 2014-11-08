//
//  entainmentCustomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "entainmentCustomCell.h"

@implementation entainmentCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backGround=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 122)];
        [self addSubview:self.backGround];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 140, 100)];
        [self.backGround addSubview:self._imageView];
        
        
        self.head=[[RTLabel alloc]initWithFrame:CGRectMake( self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.backGround.frame.origin.y+13,150 , 30)];
        self.head.font=[UIFont boldSystemFontOfSize:17];
        [  self.backGround addSubview:self.head];
        
        self.title=[[UILabel alloc]initWithFrame:CGRectMake(self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.head.frame.origin.y+self.head.frame.size.height-10,130 , 80)];
        self.title.backgroundColor=[UIColor clearColor];
        self.title.font=[UIFont systemFontOfSize:13];
        self.title.numberOfLines=0;
        [  self.backGround addSubview:self.title];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(290, 50, 20, 20)];
        imageView.image=[UIImage imageNamed:@"entainmentMore.png"];
        [self.backGround addSubview:imageView];
        UIImageView*imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.backGround.frame.size.height-2, 320, 2)];
        imageView2.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self.backGround addSubview:imageView2];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

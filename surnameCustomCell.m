//
//  surnameCustomCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "surnameCustomCell.h"

@implementation surnameCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.userImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 15, 15,15)];
        self.userImage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        [self addSubview:self.userImage];
        
        self.userName=[[UILabel alloc]initWithFrame:CGRectMake( self.userImage.frame.origin.x+self.userImage.frame.size.width+5, 15, 80, 15)];
        self.userName.font=[UIFont systemFontOfSize:12];
        self.userName.text=@"yonghuming";
        self.userName.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        [self addSubview:self.userName];
        
        self.comentDate=[[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x+self.userName.frame.size.width+5, 15, 200, 15)];
        self.comentDate.font=[UIFont systemFontOfSize:12];
        self.comentDate.textColor=[UIColor grayColor];
        self.comentDate.text=@"2014.3.21 4.4";
        [self addSubview:self.comentDate];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x, 35, 260, 10)];
//        self._imageView.backgroundColor=[UIColor greenColor];
        [self addSubview:self._imageView];
        
        
        self._imageViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x, 35, 0, 10)];
        self._imageViewTitle.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"orange.png"]];
        self._imageViewTitle.font=[UIFont systemFontOfSize:12];
        [self addSubview:self._imageViewTitle];

        
        self.title=[[RTLabel alloc]initWithFrame:CGRectMake(50,40, 240, 0)];
        
       
        
        [self addSubview:self.title];
        

        
        self.link=[[UIImageView alloc]initWithFrame:CGRectMake(50,self.title.frame.origin.y+self.title.frame.size.height+18, 260, 2)];
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

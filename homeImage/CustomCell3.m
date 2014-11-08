//
//  CustomCell3.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-18.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CustomCell3.h"

@implementation CustomCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        float X=10;
        
        float Width=100;
        float height=75;
        float Y=(100-height)/2;
    
        
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, Width, height)];
        self._imageView.image=BACK_IMAGE;
        [self addSubview:self._imageView];
        self.lableHead=[[UILabel alloc]initWithFrame:CGRectMake(115, Y+3, 195, 40)];
        self.lableHead.numberOfLines=2;
         self.lableHead.font=[UIFont boldSystemFontOfSize:14];
        [self addSubview:self.lableHead];
        
        
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.lableHead.frame.origin.x,50, 20,20)];
        self.headImage.image=BACK_IMAGE;
        [self addSubview:self.headImage];
        
        self.useName=[[UILabel alloc]initWithFrame:CGRectMake(self.headImage.frame.origin.x+27, self.headImage.frame.origin.y, 100, 20)];
        self.useName.font=[UIFont systemFontOfSize:14];
        self.useName.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        self.useName.textAlignment=NSTextAlignmentLeft;
        [self addSubview:self.useName];
        
        
        self.data=[[UILabel alloc]initWithFrame:CGRectMake( self.headImage.frame.origin.x, self.useName.frame.origin.y+ self.useName.frame.size.height+3, 200, 20)];
        self.data.font=[UIFont systemFontOfSize:13];
        self.data.textColor=[UIColor grayColor];
        [self addSubview:self.data];
        
        self.backgroundColor=GroupColor;
        


        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, 98, 320,2)];
        link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self addSubview:link];

        UIImageView*jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 20, 20)];
        jiantou.image=[UIImage imageNamed:@"cellJianTou.png"];
        [self addSubview:jiantou];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

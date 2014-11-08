//
//  CustomSceneryCell.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-9.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CustomSceneryCell.h"

@implementation CustomSceneryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backGround=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 97)];
        self.backGround.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self addSubview:self.backGround];
        
        self._imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 75)];
        self._imageView.image=[UIImage imageNamed:@"defaultSmall.gif"];
        [self.backGround addSubview:self._imageView];
        
        UIImageView*jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 20, 20)];
        jiantou.image=[UIImage imageNamed:@"cellJianTou.png"];
        [self addSubview:jiantou];
        
        
        self.russiaHead=[[UILabel alloc]initWithFrame:CGRectMake( self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.backGround.frame.origin.y+10,200 , 20)];
        self.russiaHead.text=@"Центральный";
        self.russiaHead.font=[UIFont systemFontOfSize:16];
        [  self.backGround addSubview:self.russiaHead];
        
        self.chineseHead=[[UILabel alloc]initWithFrame:CGRectMake(self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.russiaHead.frame.origin.y+self.russiaHead.frame.size.height,230 , 20)];
        self.chineseHead.textColor=[UIColor grayColor];
        self.chineseHead.text=@"圣彼得堡";
        self.chineseHead.backgroundColor=[UIColor clearColor];
        self.chineseHead.font=[UIFont systemFontOfSize:15];
        self.chineseHead.numberOfLines=0;
        [  self.backGround addSubview:self.chineseHead];
        
       
        
        self.type=[[UILabel alloc]initWithFrame:CGRectMake(self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.chineseHead.frame.origin.y+self.chineseHead.frame.size.height,130 , 20)];
        self.type.textColor=[UIColor grayColor];
        self.type.text=@"博物馆";
        self.type.backgroundColor=[UIColor clearColor];
        self.type.font=[UIFont systemFontOfSize:12];
        self.type.numberOfLines=0;
        [  self.backGround addSubview:self.type];
        
        self.gradeImage=[[UIImageView alloc]initWithFrame:CGRectMake(self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.type.frame.origin.y+self.type.frame.size.height,15 , 15)];
       // self.gradeImage.image=[UIImage imageNamed:@"secenery_coment.png"];
        [self.backGround addSubview: self.gradeImage];
      

//        self.gradeCount=[[UILabel alloc]initWithFrame:CGRectMake(self.gradeImage.frame.origin.x+self.gradeImage.frame.size.width+2, self.gradeImage.frame.origin.y,80 , 15)];
        self.gradeCount=[[UILabel alloc]initWithFrame:CGRectMake(self._imageView.frame.origin.x+self._imageView.frame.size.width+5, self.type.frame.origin.y+self.type.frame.size.height,200 , 15)];
        self.gradeCount.backgroundColor=[UIColor clearColor];
        
       // self.gradeCount.text=@"210人讲解";
        self.gradeCount.font=[UIFont systemFontOfSize:12];
        self.gradeCount.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"skyBlue.png"]];
        [self.backGround addSubview: self.gradeCount];

        
        self.price=[[RTLabel alloc]initWithFrame:CGRectMake(250, self.gradeImage.frame.origin.y-5, 60, 30)];
        self.price.textColor=[UIColor grayColor];
        //self.price.text=[NSString stringWithFormat:@"$<font size=21 color=orange>520</font>起"];
        self.price.textAlignment=RTTextAlignmentRight;
        [self.backGround addSubview: self.price];

   
        UIImageView*imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.backGround.frame.size.height-2, 320, 2)];
        imageView2.image=[UIImage imageNamed:@"entainmentLink.png"];
        [self.backGround addSubview:imageView2];
  
        
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
